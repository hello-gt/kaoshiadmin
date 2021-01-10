<?php
// +----------------------------------------------------------------------
// | snake
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2022 http://baiyf.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: NickBai <1902822973@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\model\QuestionModel;

class Question extends Base
{
    // 文章列表
    public function index()
    {
        if(request()->isAjax()){

            $param = input('param.');

            $limit = $param['pageSize'];
            $offset = ($param['pageNumber'] - 1) * $limit;

            $where = [];
            if (!empty($param['searchText'])) {
                $where['title'] = ['like', '%' . $param['searchText'] . '%'];
            }

            $Question = new QuestionModel();
            $selectResult = $Question->getQuestionsByWhere($where, $offset, $limit);

            foreach($selectResult as $key=>$vo){
                //$selectResult[$key]['thumbnail'] = '<img src="' . $vo['thumbnail'] . '" width="40px" height="40px">';
                $selectResult[$key]['operate'] = showOperate($this->makeButton($vo['id']));
            }

            $return['total'] = $Question->getAllQuestions($where);  // 总数据
            $return['rows'] = $selectResult;
            return json($return);
        }

        return $this->fetch();
    }

    // 添加文章
    public function QuestionAdd()
    {
        if(request()->isPost()){
            $param = input('post.');

            unset($param['file']);
            $param['add_time'] = date('Y-m-d H:i:s');

            $Question = new QuestionModel();
            $flag = $Question->addQuestion($param);

            return json(msg($flag['code'], $flag['data'], $flag['msg']));
        }

        return $this->fetch();
    }

    public function QuestionEdit()
    {
        $Question = new QuestionModel();
        if(request()->isPost()){

            $param = input('post.');
            unset($param['file']);
            $flag = $Question->editQuestion($param);

            return json(msg($flag['code'], $flag['data'], $flag['msg']));
        }

        $id = input('param.id');
        $this->assign([
            'Question' => $Question->getOneQuestion($id)
        ]);
        return $this->fetch();
    }

    public function QuestionDel()
    {
        $id = input('param.id');

        $Question = new QuestionModel();
        $flag = $Question->delQuestion($id);
        return json(msg($flag['code'], $flag['data'], $flag['msg']));
    }

    // 上传缩略图
    public function uploadImg()
    {
        if(request()->isAjax()){

            $file = request()->file('file');
            // 移动到框架应用根目录/public/uploads/ 目录下
            $info = $file->move(ROOT_PATH . 'public' . DS . 'upload');
            if($info){
                $src =  '/upload' . '/' . date('Ymd') . '/' . $info->getFilename();
                return json(msg(0, ['src' => $src], ''));
            }else{
                // 上传失败获取错误信息
                return json(msg(-1, '', $file->getError()));
            }
        }
    }

    /**
     * 拼装操作按钮
     * @param $id
     * @return array
     */
    private function makeButton($id)
    {
        return [
            '编辑' => [
                'auth' => 'Questions/Questionedit',
                'href' => url('Questions/Questionedit', ['id' => $id]),
                'btnStyle' => 'primary',
                'icon' => 'fa fa-paste'
            ],
            '删除' => [
                'auth' => 'Questions/Questiondel',
                'href' => "javascript:QuestionDel(" . $id . ")",
                'btnStyle' => 'danger',
                'icon' => 'fa fa-trash-o'
            ]
        ];
    }
}
