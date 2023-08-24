## 24 Agustus 2023
### Solid Principle
1. Single Responsibilities Principle  
**A Class Should Have just one reason to change**
2. Open closed Principle  
**A Class Should be open for extention but closed for modification**
3. Liskov Subtitution Principle   
**when extending a class remember that you should be able to pass object of subclass in place of object of parent class without breaking client code**  
  - parameter type in subclass should **match** or be **more abstract** than parameter type in super class
  - return type in method of subclass should **match** or a **subtype** of return type in super class
  - a method in subclass should not throw types of exception which base class not expecting to throw
  - a subclass shouldnot **strengthen** pre-condition
  - a subclass shouldnot **weaken** post-condition
  - **invariant** of superclass must be preserved
  - a subclass shouldnot change values of private fields of superclass
    
4. Interface Segregation principle
**client should not be forced to depend on method they donot use**
  - class inheritance only have one of superclass, but doesnt limit number of interface them implement

5. Dependency Inversion Principle
**high-level classes should not depend on low-level classes, both should depend on abstraction. abstraction shouldnot depend on detail. detail should depend on abstraction**
