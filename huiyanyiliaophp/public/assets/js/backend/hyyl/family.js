define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'hyyl/family/index' + location.search,
                    add_url: 'hyyl/family/add',
                    edit_url: 'hyyl/family/edit',
                    del_url: 'hyyl/family/del',
                    multi_url: 'hyyl/family/multi',
                    import_url: 'hyyl/family/import',
                    table: 'hyyl_family',
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
                        {
                            field: 'user_id',
                            title: __('User_id'),
                            operate: "LIKE",
                            align:'left',
                            formatter: function (value,row,index) {
                                if (row.user){
                                    return row.user.nickname;
                                }return ' ';
                            },
                            addclass: 'selectpage',
                            extend:"data-source=\"user/user/index\" data-field=\"nickname\""
                        },
                        {field: 'relationship', title: __('Relationship'),align:'left', searchList:{1:__('配偶/子女'),2:__('父母/亲戚朋友'),3:__('员工')},operate: 'LIKE', formatter: Table.api.formatter.normal},
                        {field: 'name', title: __('Name'), operate: 'LIKE',align:'left'},
                        //{field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'sex', title: __('Sex'), searchList: {"1":__('男'),"2":__('女')}, align:'left',formatter: Table.api.formatter.normal},
                        {field: 'phone', title: __('Phone'), operate: 'LIKE',align:'left'},


                        {field: 'sbimages', title: __('Sbimages'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.images},
                        {field: 'approvestatus', title: __('Approvestatus'), custom: {1: 'success',2:'info',3:'danger'},searchList: {"1":__('Approvestatus 1'),"2":__('Approvestatus 2'),"3":__('Approvestatus 3')}, formatter: Table.api.formatter.status},


                        {field: 'approvetime', title: __('Approvetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'rason', title: __('Rason'),operate: false,align:'left', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'status', title: __('Status'), operate:false, searchList: {"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},
                        // {field: 'createtime', title: __('Createtime'), operate:false, addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table,
                            events: Table.api.events.operate,
                            formatter: Table.api.formatter.operate,
                            buttons:[
                                {
                                    name:'approve',
                                    text:"审核",
                                    title:"审核",
                                    icon:'fa fa-edit',
                                    classname:" btn btn-xs btn-primary btn-dialog",
                                    url:"hyyl/family/approve",
                                    visible:function (row) {
                                        return row.approvestatus ==2;
                                    }
                                }
                            ]}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        recyclebin: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    'dragsort_url': ''
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: 'hyyl/family/recyclebin' + location.search,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'name', title: __('Name'), align: 'left'},
                        {
                            field: 'deletetime',
                            title: __('Deletetime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            width: '140px',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'Restore',
                                    text: __('Restore'),
                                    classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
                                    icon: 'fa fa-rotate-left',
                                    url: 'hyyl/family/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'hyyl/family/destroy',
                                    refresh: true
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
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
        approve: function () {
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
