package greeting.example;

import io.swagger.v3.oas.annotations.Hidden;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Pattern;

@RestController
public class GreetingController {

    private final GreetingService greetingService;
    private static final String PREFIX="2016-08-15/proxy/FaaSDemo.LATEST/svm_hello";
    
    public GreetingController(GreetingService greetingService) {
        this.greetingService = greetingService;
    }

    @GetMapping(PREFIX+"/greeting")
    public Greeting greeting(@RequestParam(value="name", defaultValue="World") @Pattern(regexp = "\\D+") String name) {
        return greetingService.greeting(name);
    }

    @PostMapping(PREFIX+"/greeting")
    public Greeting greetingByPost(@RequestBody Greeting greeting) {
        return greetingService.greeting(greeting.getContent());
    }

    @DeleteMapping(PREFIX+"/greeting")
    @Hidden
    public ResponseEntity<?> deleteGreeting() {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("Foo", "Bar");
        return new ResponseEntity<>(headers, HttpStatus.NO_CONTENT);
    }


    @GetMapping(PREFIX+"/greeting-status")
    @ResponseStatus(code = HttpStatus.CREATED)
    public Greeting greetingWithStatus(@RequestParam(value="name", defaultValue="World") @Pattern(regexp = "\\D+") String name) {
        return greetingService.greeting(name);
    }

    @GetMapping(path = PREFIX+"/", produces = "text/html")
    public String home(Model model) {
        model.addAttribute(
                "message",
                "Welcome to Micronaut for Spring");

        return "home";
    }    
}