define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/hospital/index' + location.search,
                    add_url: 'hyyl/hospital/add',
                    edit_url: 'hyyl/hospital/edit',
                    del_url: 'hyyl/hospital/del',
                    multi_url: 'hyyl/hospital/multi',
                    import_url: 'hyyl/hospital/import',
                    table: 'hyyl_hospital',
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
                searchFormVisible:true,
                columns: [
                    [
                        // {checkbox: true},
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'coverimage', title: __('Coverimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},

                        //{field: 'groupimages', title: __('Groupimages'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.images},
                        {field: 'name', title: __('Name'), operate: 'LIKE',align:'left'},

                        {field: 'shordesc', title: __('Shordesc'), operate: 'LIKE', table: table, class: 'autocontent',align:'left', formatter: Table.api.formatter.content},

                        {field: 'address', title: __('Address'), operate: 'LIKE', table: table, class: 'autocontent',align:'left', formatter: Table.api.formatter.content},
                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'status', title: __('Status'), searchList: {"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},

                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange',align:'left', autocomplete:false, formatter: Table.api.formatter.datetime},
                       // {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},


                        //{field: 'longitude', title: __('Longitude'), operate: 'LIKE'},
                        // {field: 'latitude', title: __('Latitude'), operate: 'LIKE'},
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
