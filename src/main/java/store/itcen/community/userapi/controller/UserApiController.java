package store.itcen.community.userapi.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import store.itcen.community.userapi.dto.LoginRequestDTO;
import store.itcen.community.userapi.dto.LoginResponseDTO;
import store.itcen.community.userapi.dto.UserSignUpDTO;
import store.itcen.community.userapi.dto.UserSignUpResponseDTO;
import store.itcen.community.userapi.exception.DuplicatedEmailException;
import store.itcen.community.userapi.exception.NoRegisteredArgumentsException;
import store.itcen.community.userapi.service.UserService;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/auth")
public class UserApiController {

    private final UserService userService;

    // 회원가입 요청 처리
    @PostMapping("/signup")
    public String signUp(
             UserSignUpDTO signUpDTO
    ) {
        log.info("/api/auth/signup POST! - {}", signUpDTO);

        try {
            UserSignUpResponseDTO responseDTO
                    = userService.create(signUpDTO);
            return "redirect:/login";
        } catch (NoRegisteredArgumentsException e) {
            // 예외 상황 2가지 (dto가 null인 문제, 이메일 중복문제)
            log.warn("필수 가입 정보를 다시확인하세요.");
            return "";
        } catch (DuplicatedEmailException e) {
            log.warn("중복되었습니다. 다른 이메일을 작성해주세요.");
            return "";
        }
    }


    @PostMapping("/signin")
    public String signIn(
            @Validated @RequestBody LoginRequestDTO requestDTO) {

        try {
            LoginResponseDTO userInfo = userService.getByCredentials(
                    requestDTO.getEmail(),
                    requestDTO.getPassword()
            );
            return "redirect:/";
        } catch (RuntimeException e) {
            log.warn("비밀번호 오류");
            return "";
        }

    }

}
