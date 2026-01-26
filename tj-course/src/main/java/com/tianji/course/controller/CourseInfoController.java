package com.tianji.course.controller;

import com.tianji.api.dto.course.*;
import com.tianji.common.utils.CollUtils;
import com.tianji.course.service.ICategoryService;
import com.tianji.course.service.ICourseCatalogueService;
import com.tianji.course.service.ICourseService;
import io.swagger.v3.oas.annotations.Hidden;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 内部服务接口调用
 *
 **/
@RestController
@RequestMapping("course")
@Tag(name = "课程相关接口，内部调用")
@RequiredArgsConstructor
public class CourseInfoController {

    private final ICourseCatalogueService courseCatalogueService;
    private final ICourseService courseService;
    private final ICategoryService categoryService;

    @GetMapping("infoByTeacherIds")
    @Operation(description = "通过老师 id 获取老师负责的课程和出的题目数量")
    public List<SubNumAndCourseNumDTO> infoByTeacherIds(@RequestParam("teacherIds") List<Long> teacherIds) {
        if (CollUtils.isEmpty(teacherIds)) {
            return new ArrayList<>();
        }
        return courseService.countSubjectNumAndCourseNumOfTeacher(teacherIds);
    }

    /**
     * 根据小节 id 获取小节对应的 mediaId 和课程 id
     *
     * @param sectionId 小节 id
     * @return 小节对应的 mediaId 和课程 id
     */
    @GetMapping("/section/{id}")
    @Operation(description = "小节id，不支持章id或者练习id查询")
    public SectionInfoDTO sectionInfo(@PathVariable("id") Long sectionId) {
        return courseCatalogueService.getSimpleSectionInfo(sectionId);
    }

    /**
     * 根据媒资 Id 列表查询媒资被引用的次数
     *
     * @param mediaIds 媒资 id列表
     * @return 媒资 id和媒资被引用的次数的列表
     */
    @GetMapping("/media/useInfo")
    public List<MediaQuoteDTO> mediaUserInfo(@RequestParam("mediaIds") List<Long> mediaIds) {
        return courseCatalogueService.countMediaUserInfo(mediaIds);
    }

    @GetMapping("/{id}/searchInfo")
    @Operation(description = "课程上架时，需要查询课程信息，加入索引库")
    public CourseDTO getSearchInfo(@PathVariable @Parameter(description = "课程 id") Long id) {
        return courseService.getCourseDTOById(id);
    }

    @GetMapping("/{id}")
    @Operation(description = "获取课程信息")
    @Parameters({
            @Parameter(name = "id", description =  "获取课程信息"),
            @Parameter(name = "withCatalogue", description = "是否要查询目录信息"),
            @Parameter(name = "withTeachers", description = "是否查询课程老师信息")
    })
    public CourseFullInfoDTO getById(
             @PathVariable Long id,
            @RequestParam(value = "withCatalogue", required = false) boolean withCatalogue,
            @RequestParam(value = "withTeachers", required = false) boolean withTeachers) {
        return courseService.getInfoById(id, withCatalogue, withTeachers);
    }


    @GetMapping("/getCateNameMap")
    @Hidden
    public Map<Long, String> queryByThirdCateIds(@RequestParam("thirdCateIdList") List<Long> thirdCateIdList) {
        return categoryService.queryByThirdCateIds(thirdCateIdList);
    }

    @GetMapping("/name")
    public List<Long> queryCoursesIdByName(@RequestParam("name") String name){
        return courseService.queryCourseIdByName(name);
    }
}
