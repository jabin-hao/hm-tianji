package com.tianji.course.controller;

import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.tianji.api.dto.course.CourseSimpleInfoDTO;
import com.tianji.common.domain.dto.PageDTO;
import com.tianji.common.validate.annotations.ParamChecker;
import com.tianji.course.constants.CourseStatus;
import com.tianji.course.domain.dto.*;
import com.tianji.course.domain.vo.*;
import com.tianji.course.service.*;
import com.tianji.course.utils.CourseSaveBaseGroup;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

/**
 * 课程 controller
 **/
@Tag(name = "课程相关接口")
@RestController
@RequestMapping("courses")
@Slf4j
@Validated
@RequiredArgsConstructor
public class CourseController {

    private final  ICourseDraftService courseDraftService;
    private final  ICourseCatalogueDraftService courseCatalogueDraftService;
    private final  ICourseTeacherDraftService courseTeacherDraftService;
    private final  ICourseService courseService;
    private final  ICourseCatalogueService courseCatalogueService;

    //todo 二期做
//    @GetMapping("statistics")
//    @ApiOperation("课程数据统计")
    public CourseStatisticsVO statistics() {
        return null;
    }

    @GetMapping("baseInfo/{id}")
    @Operation(description = "获取课程基础信息")
    @Parameters({
            @Parameter(name = "id", description = "课程 id"),
            @Parameter(name = "see", description = "是否是用于查看页面查看数据，默认是查看,如果不是界面查看数据就是编辑页面使用")
    })
    public CourseBaseInfoVO baseInfo(@PathVariable Long id,
                                     @RequestParam(value = "see", required = false, defaultValue = "1") Boolean see) {
        return courseDraftService.getCourseBaseInfo(id, see);
    }

    @PostMapping("baseInfo/save")
    @Operation(description = "保存课程基本信息")
    @ParamChecker
    //校验非业务限制的字段
    public CourseSaveVO save(@RequestBody @Validated(CourseSaveBaseGroup.class) CourseBaseInfoSaveDTO courseBaseInfoSaveDTO) {
        return courseDraftService.save(courseBaseInfoSaveDTO);
    }

    @GetMapping("catas/{id}")
    @Operation(description = "获取课程的章节")
    @Parameters({
            @Parameter(name = "id", description = "课程 id"),
            @Parameter(name = "see", description = "是否是用于查看页面查看数据，默认是查看,如果不是界面查看数据就是编辑页面使用")
    })
    public List<CataVO> catas(@PathVariable(required = false) Long id,
                              @RequestParam(value = "see", required = false, defaultValue = "1") Boolean see,
                              @RequestParam(value = "withPractice", required = false, defaultValue = "1") Boolean withPractice) {
        return courseCatalogueDraftService.queryCourseCatalogues(id, see, withPractice);
    }

    @PostMapping("catas/save/{id}/{step}")
    @Operation(description = "保存章节")
    @Parameters({
            @Parameter(name = "id", description = "课程 id"),
            @Parameter(name = "step", description = "步骤")
    })
    @ParamChecker
    public void catasSave(@RequestBody @Validated List<CataSaveDTO> cataSaveDTOS,
                          @PathVariable Long id, @PathVariable(required = false) Integer step) {
        courseCatalogueDraftService.save(id, cataSaveDTOS, step);
    }

    @PostMapping("media/save/{id}")
    @Operation(description = "课程视频")
    @Parameters({
            @Parameter(name = "id", description = "课程 id")
    })
    public void mediaSave(@PathVariable Long id, @RequestBody @Valid List<CourseMediaDTO> courseMediaDTOS) {
        courseCatalogueDraftService.saveMediaInfo(id, courseMediaDTOS);
    }

    @PostMapping("subjects/save/{id}")
    @Operation(description = "保存小节或练习中的题目")
    @Parameters({
            @Parameter(name = "id", description = "课程 id")
    })
    public void saveSubject(@PathVariable Long id, @RequestBody @Validated List<CataSubjectDTO> cataSubjectDTO) {
        courseCatalogueDraftService.saveSubject(id, cataSubjectDTO);
    }

    @GetMapping("subjects/get/{id}")
    @Operation(description = "获取小节或练习中的题目（用于编辑）")
    @Parameters({
            @Parameter(name = "id", description = "课程 id")
    })
    public List<CataSimpleSubjectVO> getSubject(@PathVariable Long id) {
        return courseCatalogueDraftService.getSubject(id);
    }

    @GetMapping("teachers/{id}")
    @Operation(description = "查询课程相关的老师信息")
    @Parameters({
            @Parameter(name = "id", description = "课程 id"),
            @Parameter(name = "see", description = "是否是用于查看页面查看数据，默认是查看,如果不是界面查看数据就是编辑页面使用")
    })
    public List<CourseTeacherVO> teacher(@PathVariable Long id,
                                         @RequestParam(value = "see", required = false, defaultValue = "1") Boolean see) {
        return courseTeacherDraftService.queryTeacherOfCourse(id, see);
    }

    @PostMapping("teachers/save")
    @Operation(description = "保存老师信息")
    public void teachersSave(@RequestBody @Validated CourseTeacherSaveDTO courseTeacherSaveDTO) {
        courseTeacherDraftService.save(courseTeacherSaveDTO);
    }


    @PostMapping("upShelf")
    @Operation(description = "课程上架")
    public void upShelf(@RequestBody @Validated CourseIdDTO courseIdDTO) {
        courseDraftService.upShelf(courseIdDTO.getId());
    }

    @GetMapping("checkBeforeUpShelf/{id}")
    @Operation(description = "课程上架前校验")
    public void checkBeforeUpShelf(@PathVariable Long id){
        courseDraftService.checkBeforeUpShelf(id);
    }

    @PostMapping("downShelf")
    @Operation(description = "课程下架")
    public void downShelf(@RequestBody @Validated CourseIdDTO courseIdDTO) {
        courseDraftService.downShelf(courseIdDTO.getId());
    }

    /**
     * 先去删除加上数据删除后，再去删除草稿
     */
    @DeleteMapping("delete/{id}")
    @Operation(description = "课程删除")
    @Parameters({
            @Parameter(name = "id", description = "id")
    })
    public void deleteById(@PathVariable Long id) {
        courseService.delete(id);
    }

    @Operation(description = "根根条件列表获取课程信息")
    @GetMapping("/simpleInfo/list")
    public List<CourseSimpleInfoDTO> getSimpleInfoList(CourseSimpleInfoListDTO courseSimpleInfoListDTO) {
        return courseService.getSimpleInfoList(courseSimpleInfoListDTO);
    }

    @Operation(description = "根据课程id，查询所有章节的序号")
    @GetMapping("/catas/index/list/{id}")
    @Parameters(
            @Parameter(name = "id", description = "课程 id")
    )
    public List<CataSimpleInfoVO> catasIndexList(@PathVariable Long id) {
        return courseCatalogueService.getCatasIndexList(id);
    }

    @Operation(description = "生成练习 id")
    @GetMapping("generator")
    public CourseCataIdVO generator() {
        return new CourseCataIdVO(IdWorker.getId());
    }

    @Operation(description = "管理端课程搜索接口")
    @GetMapping("/page")
    public PageDTO<CoursePageVO> queryForPage(CoursePageQuery coursePageQuery) {
        if(CourseStatus.NO_UP_SHELF.equals(coursePageQuery.getStatus()) ||
        CourseStatus.DOWN_SHELF.equals(coursePageQuery.getStatus())){
            //待上架已下架查询草稿
            return courseDraftService.queryForPage(coursePageQuery);
        }else {
            //已上架已完结查询正式数据
            return courseService.queryForPage(coursePageQuery);
        }
    }

    @Operation(description = "校验课程名称是否已经存在")
    @GetMapping("/checkName")
    @Parameters({
            @Parameter(name = "id", description = "id"),
            @Parameter(name = "name", description = "课程名称")
    })
    public NameExistVO checkNameExist(@RequestParam(value = "id",required = false) Long id,
                                      @RequestParam(value = "name") String name){
        return courseService.checkName(name, id);
    }

    @Operation(description = "查询课程基本信息、目录、学习进度")
    @GetMapping("/{id}/catalogs")
    public CourseAndSectionVO queryCourseAndCatalogById(@PathVariable("id") Long courseId){
        return courseService.queryCourseAndCatalogById(courseId);
    }
}
