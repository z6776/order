define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/order/index' + location.search,
                    // add_url: 'hyyl/order/add',
                    // edit_url: 'hyyl/order/edit',
                    // del_url: 'hyyl/order/del',
                    multi_url: 'hyyl/order/multi',
                    import_url: 'hyyl/order/import',
                    table: 'hyyl_order',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                search: false,//快捷搜索,这里可在控制器定义快捷搜索的字段
                commonSearch: true,//启用普通表单搜索
                showExport: false, //显示导出按钮
                showToggle:false,//是否显示切换视图
                showColumns:false, //是否显示内容列下拉框。
                searchFormVisible:true,//是否始终显示高级搜索表单
                columns: [
                    [
                        //{checkbox: true},
                        // {field: 'id', title: __('Id')},
                        // {field: 'out_trade_no', title: __('Out_trade_no'),operate: 'LIKE'},
                        {field: 'user_id', title: __('下单人id'),operate: false},
                        {field: 'user_id', title: __('下单人昵称'),operate: false,
                            formatter: function(value,row,index){
                            if (row.user){
                                return row.user.nickname;
                            }return ' ';
                            },
                            addclass: 'selectpage',
                            extend:"data-source=\"user/user/index\" data-field=\"nickname\""},
                        {field: 'type', title: __('预约服务'), searchList: {"1":__('问诊'),"2":__('专家'),"3":"体检","4":"住院"}, formatter: Table.api.formatter.normal},
                        {field: 'family.relationship_text', title: __('就诊关系'), searchList: {"1":__('配偶/子女'),"2":__('父母/兄妹'),"3":"员工"}},
                        {
                            field: 'family_id',
                            title: __('患者姓名'),
                            operate: false,
                            formatter:function (value,row,index) {
                                if (row.family){
                                    return row.family.name;
                                }return ' ';},
                            addclass: 'selectpage',
                            extend: 'data-source=\"hyyl/family/index\" data-field=\"name\"'
                        },
                        {field: 'family.sex_text', title: __('性别'),operate: false},
                        {field: 'family.birthday', title: __('出生年月'),operate: false},
                        {field: 'family.phone', title: __('手机号码'),operate: false},
                        {field: 'family.addres', title: __('现住地址'),operate: false},
                        {
                            field: 'hospital_id', title: __('意向医院'),
                            operate: 'LIKE',
                            table: table,
                            class: 'autocontent',
                            formatter: function (value,row,index){
                                if (row.hospital){
                                    return row.hospital.name;
                                }return " ";},
                            addclass: 'selectpage',
                            extend:"data-source=\"hyyl/hospital/index\" data-field=\"name\""
                        },
                        {field: 'visit_time', title: __('Visit_time'), operate:'RANGE', addclass:'datetimerange', autocomplete:false},
                        {field: 'typedata', title: __('陪诊需求'), searchList: {"1":__('自行问诊'),"2":__('专人陪诊')}, formatter: Table.api.formatter.normal},
                        {field: 'describe', title: __('病例描述'),operate: false, table: table, class: 'autocontent',align:'left', formatter: Table.api.formatter.content},
                        {field: 'annex', title: __('病例附件'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {
                            field: 'status',
                            title: __('Status'),
                            custom: {1: '需求发布',2:'服务中',3:'已完成', 4: '已取消'},
                            searchList: {1: '需求发布',2:'服务中',3:'已完成', 4: '已取消'},
                            formatter: Table.api.formatter.status
                        },

                        {field: 'finishtime', title: __('处理时间'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'remarks', title: __('备注'),operate: false},
                        // {field: 'createtime', title: __('Createtime'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                         {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate,
                             buttons: [
                                 {
                                     name: 'detail',
                                     text: '处理',
                                     title: '处理',
                                     icon: 'fa fa-info',
                                     classname: 'btn btn-xs btn-info btn-dialog',
                                     url: 'hyyl/order/edit',
                                     visible: function (row) {
                                         if(row.status === '2'){
                                             return true;
                                         }else {
                                             return false;
                                         }
                                     }
                                 },
                                 {
                                     name: 'refuse',
                                     text: '开始服务',
                                     classname: 'btn btn-xs btn-info btn-ajax',
                                     extend: 'data-toggle="tooltip"',
                                     icon: 'fa fa-send',
                                     url: 'hyyl/order/service',
                                     visible: function (row) {
                                         if(row.status === '1'){
                                             return true;
                                         }else {
                                             return false;
                                         }
                                     },
                                     refresh:true
                                 }
                             ]}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        },

    };

    return Controller;
});
