// Where filter

// Filter only odd number from list
// void main(){
//     List<int> nums = [1,2,3,4,5,6,7,8,9,10];
//     var result = nums.where((num) => num%2 != 0);
//     print(result.toList());
// }

// Filter days start with 'S'
// void main(){
//     List<String> days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

//     List<String> filteredDays = days.where((day) => day.startsWith('S')).toList();
//     print(filteredDays);
// }

void Marks(){
    Map<String, double> marks = {
        'Ram': 90,
        'Hari': 80,
        'Shyam': 50
    };

    marks.removeWhere((key, value) => value < 60);
    print(marks);
}

void main(){
    Marks();
}