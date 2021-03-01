<?php
namespace app\command\controller;
 
use think\Controller;
 
/**
 * 命令行控制器
 *
 * @package app\index\controller
 */
class Index extends Controller
{
    public function test()
    {
        $res = http_curl("https://www.zujuan.com/api/question/list?xd=3&chid=6&categories=2236&knowledges=&question_channel_type=&difficult_index=&exam_type=&kid_num=&grade_id=&sort_field=time&filterquestion=0&content=&page=2&version_id=&_=1614591766451");

        var_dump($res);die;
    }
}