<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/12/23
 * Time: 12:35
 */
 
namespace app\command;
 
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
 
class Action extends Command
{
    protected function configure()
    {
        $this->setName('action')
            ->addArgument('route', Argument::OPTIONAL, "your run  route path! ")//路由地址必须输入
            ->addOption('option', 'o', Option::VALUE_REQUIRED, 'set Controller Argument')//参数选填
            ->setDescription('Command run Controller Action!');
    }
 
    protected function execute(Input $input, Output $output)
    {
        $Argument = $input->getArguments();
        if ($Argument['command'] == 'action') {
            if ($input->hasOption('option')) {
                $result = action($this->route($Argument['route']), $input->getOption('option'));
                $output->writeln($result);
            } else {
                $result = action($this->route($Argument['route']));
                $output->writeln($result);
            }
        }
    }
 
    public function route($route = '')
    {
        if ($route) {
            $route = explode('/', $route);
            $module = isset($route[0]) ? $route[0] : 'index';
            $controller = isset($route[1]) ? $route[1] : 'index';
            $action = isset($route[2]) ? $route[2] : 'index';
            return $module . '/' . $controller . '/' . $action;
        }
        return $route;
    }
}
