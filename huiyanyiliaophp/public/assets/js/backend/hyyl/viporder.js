define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/viporder/index' + location.search,
                    add_url: 'hyyl/viporder/add',
                    edit_url: 'hyyl/viporder/edit',
                    del_url: 'hyyl/viporder/del',
                    multi_url: 'hyyl/viporder/multi',
                    import_url: 'hyyl/viporder/import',
                    table: 'hyyl_viporder',

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
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'out_trade_no', title: __('Out_trade_no'), operate: 'LIKE'},

                        {field: 'user_id', title: __('User_id'),formatter: function (value,row,index) {
                                if (row.user){
                                    return row.user.nickname;
                                }return ' ';
                            },
                            addclass: 'selectpage',
                            extend:"data-source=\"user/user/index\" data-field=\"nickname\""


                            },
                        {field: 'viplevel_id', title: __('Viplevel_id'),
                            formatter: function (value,row,index) {
                                if (row.viplevel){
                                    return row.viplevel.name;
                                }return ' ';
                            },
                            addclass: 'selectpage',
                            extend:"data-source=\"hyyl/viplevel/index\" data-field=\"name\""
                        },

                        //{field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'paytype', title: __('Paytype'), operate: false,searchList: {"wechat":__('wechat'),"sysadmin":__('sysadmin')}},
                        {field: 'paytime', title: __('Paytime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},

                        {field: 'createtime', title: __('Createtime'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'pay_fee', title: __('Pay_fee'), operate:'BETWEEN'},
                        // {field: 'status', title: __('Status'), searchList: {"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
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
        }
    };
    return Controller;
});
