public class UserRoleChecker {
    public static void checkUserRole(String role) {
        if (role == 'Admin') {
            System.debug('User has Admin access.');
        }
        if (role == 'Editor') {
            System.debug('User has Editor access.');
        }
        if (role == 'Viewer') {
            System.debug('User has Viewer access.');
        }
        if (role == 'Guest') {
            System.debug('User has Guest access.');
        } else {
            System.debug('User role is not recognized.');
        }
    }
    public static void checkUserGrade(Integer grade) { 
        if (grade >= 90) {
            System.debug('Grade: A');
        }
        if (grade >= 80 && grade < 90) {
            System.debug('Grade: B');
        }
        if (grade >= 70 && grade < 80) {
            System.debug('Grade: C');
        }
        if (grade >= 60 && grade < 70) {
            System.debug('Grade: D');
        } else {
            System.debug('Grade: F');
        }
    }
}