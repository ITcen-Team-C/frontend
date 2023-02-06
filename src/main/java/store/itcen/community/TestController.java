package store.itcen.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import store.itcen.community.postapi.dto.PostCreateRequestDTO;
import store.itcen.community.postapi.entity.PostEntity;
import store.itcen.community.postapi.repository.PostRepository;
import store.itcen.community.userapi.repository.UserRepository;

@Controller
public class TestController {


    UserRepository userRepository;
    PostRepository postRepository;

    @Autowired
    public TestController(UserRepository userRepository, PostRepository postRepository) {
        this.userRepository = userRepository;
        this.postRepository = postRepository;
    }


    @GetMapping("/test")
    public String tester() {
        return "test";
    }


    @GetMapping("/write")
    public String join() {
//        userRepository.save(new UserEntity("uuid", "email2", "password2", "nickname2", LocalDateTime.now()));
        return "write";
    }

//    @GetMapping("write")
//    public String write() {
//        postRepository.save(new PostEntity("uupostid", "title", "contents", 1000L, LocalDateTime.now(), new UserEntity("uuid2", "email3", "password3", "nickname3", LocalDateTime.now()), "402880ab8615ea15018615ea26a60000"));
//        return "redirect:/test";
//    }

    @ResponseBody
    @PostMapping("/community/writeProcess")
    public ResponseEntity<?> writeProcess(@RequestBody PostCreateRequestDTO postCreateRequestDTO, Model model) {
        System.out.println(postCreateRequestDTO);

        PostEntity postEntity = postCreateRequestDTO.toEntity();
        postRepository.save(postEntity);

        model.addAttribute("response", new ResponseEntity<>(postCreateRequestDTO, HttpStatus.OK));

        return ResponseEntity
                .ok()
                .body(postCreateRequestDTO);
    }


}