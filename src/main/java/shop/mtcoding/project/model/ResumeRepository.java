package shop.mtcoding.project.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import shop.mtcoding.project.dto.resume.ResumeResp.ResumeRecommendRespDto;

@Mapper
public interface ResumeRepository {
    public void findAll();
    public void findById(

    );

    public List<ResumeRecommendRespDto> findAllResumebyPublic();

    public int insert(

    );
    public int updateById(

    );
    public int deleteById(

    );
}
