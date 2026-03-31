define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/cooperate/index' + location.search,
                    add_url: 'hyyl/cooperate/add',
                    edit_url: 'hyyl/cooperate/edit',
                    del_url: 'hyyl/cooperate/del',
                    multi_url: 'hyyl/cooperate/multi',
                    import_url: 'hyyl/cooperate/import',
                    table: 'hyyl_cooperate',
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
                        //{field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'user_id', title: __('User_id'),operate: 'LIKE',
                            formatter: function (value,row,index) {
                                if (row.user){
                                    return row.user.nickname;
                                }return ' ';
                            },
                            addclass: 'selectpage',
                            extend:"data-source=\"user/user/index\" data-field=\"nickname\""
                        },
                        {field: 'hospital_id', title: __('Hospital'), operate: 'LIKE', table: table, class: 'autocontent',
                            formatter: function (value,row,index){
                                if (row.hospital){
                                    return row.hospital.name;
                                }return " ";},
                            addclass: 'selectpage',
                            extend:"data-source=\"hyyl/hospital/index\" data-field=\"name\""
                        },
                        {field: 'expert_id', title: __('Expert_id'), operate: 'LIKE'},
                        {field: 'phone', title: __('Phone'), operate: 'LIKE'},
                        {field: 'remark', title: __('Remark'), operate: false, table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'createtime', title: __('Createtime'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'status', title: __('Status'), searchList: {"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},
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
