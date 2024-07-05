package com.itwill.gaebokchi.repository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwill.gaebokchi.dto.CommPostListDto;
import java.time.LocalDateTime;

public class JsonFormatTest {
    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();

        CommPostListDto dto = CommPostListDto.builder()
                .id(1)
                .title("Test Title")
                .author("Author")
                .category("Category")
                .views(100)
                .likes(50)
                .modifiedTime(LocalDateTime.now())
                .build();

        String jsonString = mapper.writeValueAsString(dto);
        System.out.println(jsonString);
    }
}
