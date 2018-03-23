知识点：
1.打印sql语句：在mybatis配置文件中添加   <setting name="logImpl" value="STDOUT_LOGGING" />
2.mybatis映射文件中的mysql模糊查询：like concat('%',#{param},'%')  或者 like '%${param}%' ，推荐使用前者，可以避免sql注入
3.mysql中用ifnull函数可代替oracle中的nvl函数。