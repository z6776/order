define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'user/user/index',
                    add_url: 'user/user/add',
                    edit_url: 'user/user/edit',
                    del_url: 'user/user/del',
                    multi_url: 'user/user/multi',
                    table: 'user',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'user.id',
                search: false,//快捷搜索,这里可在控制器定义快捷搜索的字段
                commonSearch: true,//启用普通表单搜索
                showExport: false, //显示导出按钮
                showToggle:false,//是否显示切换视图
                showColumns:false, //是否显示内容列下拉框。
                searchFormVisible:true,//是否始终显示高级搜索表单
                columns: [
                    [
                        //{checkbox: true},
                        {field: 'id', title: __('Id'), sortable: true,operate: false},
                        {field: 'nickname', title: __('Nickname'), operate: 'LIKE'},
                        //{field: 'group.name', title: __('Group')},
                        {field: 'username', title: __('Username'), operate: 'LIKE'},
                        {field: 'avatar', title: __('Avatar'), events: Table.api.events.image, formatter: Table.api.formatter.image, operate: false},
                        {field: 'email', title: __('Email'), operate: 'LIKE'},
                        {field: 'mobile', title: __('Mobile'), operate: 'LIKE'},
                        //{field: 'level', title: __('Level'), operate: 'BETWEEN', sortable: true},
                        // {field: 'levelname', title: __('会员等级名称'), formatter:function (value,row,index) {
                        //         if (row.viplevel){
                        //             return row.viplevel.name;
                        //         }return ' ';
                        //     }},
                        {field: 'gender', title: __('Gender'), visible: true, searchList: {0: __('男'), 1: __('女')},formatter: Table.api.formatter.normal},
                        //{field: 'score', title: __('Score'), operate: 'BETWEEN', sortable: true},
                        {field: 'successions', title: __('Successions'), visible: false, operate: 'BETWEEN', sortable: true},
                        {field: 'maxsuccessions', title: __('Maxsuccessions'), visible: false, operate: 'BETWEEN', sortable: true},
                        //{field: 'logintime', title: __('Logintime'), formatter: Table.api.formatter.datetime, operate: 'RANGE', addclass: 'datetimerange', sortable: true},
                        //{field: 'loginip', title: __('Loginip'), formatter: Table.api.formatter.search},
                        //{field: 'jointime', title: __('Jointime'), formatter: Table.api.formatter.datetime, operate: 'RANGE', addclass: 'datetimerange', sortable: true},
                        //{field: 'joinip', title: __('Joinip'), formatter: Table.api.formatter.search},
                        {field: 'levelname', title: __('会员等级名称'), formatter:function (value,row,index) {
                        if (row.viplevel){
                            return row.viplevel.name;
                        }return ' ';
                            }},
                        {field: 'applytime', title: __('Applytime'),operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'approvetime', title: __('Approvetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'idcart_frontimage', title: __('IdcartFrontimage'), events: Table.api.events.image, formatter: Table.api.formatter.image, operate: false},
                        {field: 'idcart_backimage', title: __('IdcartBackimage'), events: Table.api.events.image, formatter: Table.api.formatter.image, operate: false},
                        {field: 'approvestatus', title: __('Approvestatus'),
                            operate: 'LIKE',formatter: Table.api.formatter.status,
                            custom: {1: 'success',2:'info',3:'danger'},
                            searchList: {"1": __('Approvestatus 1'), "2": __('Approvestatus 2'),"3":__('Approvestatus 3')}},
                        {field: 'rason', title: __('Rason'), operate: 'LIKE'},
                        {field: 'idcardno', title: __('Idcardno'), operate: 'LIKE'},
                        {field: 'status', title: __('Status'), formatter: Table.api.formatter.status, searchList: {normal: __('Normal'), hidden: __('Hidden')}},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate,
                            formatter: Table.api.formatter.operate,
                            buttons:[
                                {
                                    name:'approve',
                                    text:"审核",
                                    title:"审核",
                                    icon:'fa fa-edit',
                                    classname:" btn btn-xs btn-primary btn-dialog",
                                    url:"user/user/approve",
                                    visible:function (row) {
                                        return row.approvestatus == 2;
                                    }
                                }
                            ]

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