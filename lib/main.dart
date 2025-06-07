// Late Keyword
/*
This keyword is used to declare a variable that will be initialized later.
*/

// late String name;
// void main(){
//     name = "Don";
//     print(name);
// }

class Person{
    late String name;

    void Greet(){
        print("Namaste, ${name}");
    }
}

void main(){
    Person person = Person();
    person.name = "Don";
    person.Greet();
}