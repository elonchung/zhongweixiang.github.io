---
title: IDEA插件easyCode  mybatis-plus宏
---

## IDEA插件easyCode  mybatis-plus宏

### entity
```java
##导入宏定义
$!define
$!init
##保存文件（宏定义）
#save("/entity", ".java")

##包路径（宏定义）
#setPackageSuffix("entity")

##自动导入包（全局变量）
$!autoImport
import com.baomidou.mybatisplus.extension.activerecord.Model;
import java.io.Serializable;

##拿到主键
#if(!$tableInfo.pkColumn.isEmpty())
    #set($pk = $tableInfo.pkColumn.get(0))
#end
##表注释（宏定义）
#tableComment("表实体类")
@SuppressWarnings("serial")
@Data
@TableName("`$!{tableInfo.obj.name}`")
public class $!{tableInfo.name} extends Model<$!{tableInfo.name}> {
    private static final long serialVersionUID = $!tool.serial();
#foreach($column in $tableInfo.fullColumn)
    #if(${column.comment})/**
    * ${column.comment}
    */#end
    
#if(${column.name}=="createTime")
    @ApiModelProperty(value = "创建时间", example = "2020-05-01 11:28:26")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
    @TableField(fill = FieldFill.INSERT)
#elseif(${column.name}=="updateTime")
    @ApiModelProperty(value = "修改时间", example = "2020-05-01 11:28:26")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
    @TableField(fill = FieldFill.INSERT_UPDATE)
#elseif(${pk.name}==${column.name})
    @TableId(value = "${column.name}", type = IdType.AUTO)
    @ApiModelProperty( name ="$!{column.name}", value="$column.comment")
#else
    @ApiModelProperty( name ="$!{column.name}", value="$column.comment")
#end
    private $!{tool.getClsNameByFullName($column.type)} $!{column.name};
#end

#foreach($column in $tableInfo.pkColumn)
    /**
     * 获取主键值
     *
     * @return 主键值
     */
    @Override
    protected Serializable pkVal() {
        return this.$!column.name;
    }
    #break
#end
}
```
### mapper
```java
##导入宏定义
$!define
$!init

##设置表后缀（宏定义）
#setTableSuffix("Mapper")

##保存文件（宏定义）
#save("/Mapper", "Mapper.java")

##包路径（宏定义）
#setPackageSuffix("mapper")

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import $!{tableInfo.savePackageName}.entity.$!tableInfo.name;

##表注释（宏定义）
#tableComment("表数据库访问层")
public interface $!{tableName} extends BaseMapper<$!tableInfo.name> {

}
```
### service
```java
##导入宏定义
$!define
$!init
##设置表后缀（宏定义）
#setTableSuffix("Service")

##保存文件（宏定义）
#save("/service", "Service.java")

##包路径（宏定义）
#setPackageSuffix("service")

import com.baomidou.mybatisplus.extension.service.IService;
import $!{tableInfo.savePackageName}.entity.$!tableInfo.name;

##表注释（宏定义）
#tableComment("表服务接口")
public interface $!{tableName} extends IService<$!tableInfo.name> {

}
```
### impl.xml

```java
##导入宏定义
$!define
$!init
##设置表后缀（宏定义）
#setTableSuffix("ServiceImpl")

##保存文件（宏定义）
#save("/service/impl", "ServiceImpl.java")

##包路径（宏定义）
#setPackageSuffix("service.impl")

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import $!{tableInfo.savePackageName}.mapper.$!{tableInfo.name}Mapper;
import $!{tableInfo.savePackageName}.entity.$!{tableInfo.name};
import $!{tableInfo.savePackageName}.service.$!{tableInfo.name}Service;
import org.springframework.stereotype.Service;

##表注释（宏定义）
#tableComment("表服务实现类")
@Service("$!tool.firstLowerCase($tableInfo.name)Service")
public class $!{tableName} extends ServiceImpl<$!{tableInfo.name}Mapper, $!{tableInfo.name}> implements $!{tableInfo.name}Service {

}
```
### controller
```java
##导入宏定义
$!init
$!define

##设置表后缀（宏定义）
#setTableSuffix("Controller")

##保存文件（宏定义）
#save("/controller", "Controller.java")

##包路径（宏定义）
#setPackageSuffix("controller")

##定义服务名
#set($serviceName = $!tool.append($!tool.firstLowerCase($!tableInfo.name), "Service"))

##定义实体对象名
#set($entityName = $!tool.firstLowerCase($!tableInfo.name))

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.api.ApiController;
import com.baomidou.mybatisplus.extension.api.R;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import $!{tableInfo.savePackageName}.entity.$!tableInfo.name;
import $!{tableInfo.savePackageName}.service.$!{tableInfo.name}Service;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

##表注释（宏定义）
#tableComment("表控制层")
@RestController
@RequestMapping("$!tool.firstLowerCase($!tableInfo.name)")
@Api(tags = "$!{tableInfo.comment}($!{tableInfo.name})") 
public class $!{tableName} extends ApiController {
    /**
     * 服务对象
     */
    @Resource
    private $!{tableInfo.name}Service $!{serviceName};

    /**
     * 分页查询所有数据
     *
     * @param page 分页对象
     * @param $!entityName 查询实体
     * @return 所有数据
     */
    @GetMapping("findAll")
    @ApiOperation(value = "分页查询所有数据 $!{tableInfo.comment}")
    public R selectAll(Page<$!tableInfo.name> page, $!tableInfo.name $!entityName) {
        return success(this.$!{serviceName}.page(page, new QueryWrapper<>($!entityName)));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("getOne/{id}")
    @ApiOperation(value = "通过主键查询单条数据 $!{tableInfo.comment}")
    public R selectOne(@PathVariable Integer id) {
        return success(this.$!{serviceName}.getById(id));
    }

    /**
     * 新增数据
     *
     * @param $!entityName 实体对象
     * @return 新增结果
     */
    @PostMapping("insert")
    @ApiOperation(value = "新增数据 $!{tableInfo.comment}")
    public R insert(@RequestBody $!tableInfo.name $!entityName) {
        return success(this.$!{serviceName}.save($!entityName));
    }

    /**
     * 修改数据
     *
     * @param $!entityName 实体对象
     * @return 修改结果
     */
    @PutMapping("update")
    @ApiOperation(value = "修改数据 $!{tableInfo.comment}")
    public R update(@RequestBody $!tableInfo.name $!entityName) {
        return success(this.$!{serviceName}.updateById($!entityName));
    }

    /**
     * 删除数据
     *
     * @param idList 主键结合
     * @return 删除结果
     */
    @DeleteMapping("delete")
    public R delete(@RequestParam("idList") List<Long> idList) {
        return success(this.$!{serviceName}.removeByIds(idList));
    }
}
```

### mapper.xml
```java
$!init
##引入mybatis支持
$!mybatisSupport

##设置保存名称与保存位置
$!callback.setFileName($tool.append($!{tableInfo.name}, "Mapper.xml"))
$!callback.setSavePath($tool.append($modulePath, "/src/main/resources/mapper"))

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="$!{tableInfo.savePackageName}.mapper.$!{tableInfo.name}Mapper">


</mapper>
```