define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/viplevel/index' + location.search,
                    add_url: 'hyyl/viplevel/add',
                    edit_url: 'hyyl/viplevel/edit',
                    del_url: 'hyyl/viplevel/del',
                    multi_url: 'hyyl/viplevel/multi',
                    import_url: 'hyyl/viplevel/import',
                    table: 'hyyl_viplevel',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'weigh',
                fixedColumns: true,
                fixedRightNumber: 1,
                search: false,//快捷搜索,这里可在控制器定义快捷搜索的字段
                commonSearch: true,//启用普通表单搜索
                showExport: false, //显示导出按钮
                showToggle:false,//是否显示切换视图
                showColumns:false, //是否显示内容列下拉框。
                searchFormVisible:false,//是否始终显示高级搜索表单
                columns: [
                    [
                        //{checkbox: true},
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'name', title: __('Name'), operate: 'LIKE'},
                        {field: 'shortdesc', title: __('Shortdesc'), operate: false, table: table, class: 'autocontent', formatter: Table.api.formatter.content},

                        //{field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'mprice', title: __('Mprice'),operate: false},
                        // {field: 'qprice', title: __('Qprice'),operate: false},
                        // {field: 'hyprice', title: __('Hyprice'),operate: false},
                        {field: 'yprice', title: __('Yprice'),operate: false},
                        {field: 'status', title: __('Status'), searchList: {"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},

                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'createtime', title: __('Createtime'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},


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
