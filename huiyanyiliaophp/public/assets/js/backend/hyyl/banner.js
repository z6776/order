define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/banner/index' + location.search,
                    add_url: 'hyyl/banner/add',
                    edit_url: 'hyyl/banner/edit',
                    del_url: 'hyyl/banner/del',
                    multi_url: 'hyyl/banner/multi',
                    import_url: 'hyyl/banner/import',
                    table: 'hyyl_banner',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'weigh',
                search: false,//快捷搜索,这里可在控制器定义快捷搜索的字段
                commonSearch: true,//启用普通表单搜索
                showExport: false, //显示导出按钮
                showToggle:false,//是否显示切换视图
                showColumns:false, //是否显示内容列下拉框。
                searchFormVisible:false,
                columns: [
                    [
                        //{checkbox: true},
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'coverimage', title: __('Coverimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'createtime', title: __('Createtime'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        //{field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'weigh', title: __('Weigh'), operate: false},
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
