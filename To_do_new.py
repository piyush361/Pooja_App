from colorama import Fore, Style, init

# Initialize colorama
init()

class ToDoList:
    def __init__(self):
        self.tasks = []

    def add_task(self, task):
        self.tasks.append(task)
        print(Fore.GREEN + f'Task "{task}" added to the list.' + Style.RESET_ALL)

    def view_tasks(self):
        if not self.tasks:
            print(Fore.YELLOW + "No tasks in the list." + Style.RESET_ALL)
        else:
            print(Fore.CYAN + "To-Do List:" + Style.RESET_ALL)
            for i, task in enumerate(self.tasks, start=1):
                print(Fore.LIGHTYELLOW_EX + f"{i}. {task}" + Style.RESET_ALL)

    def delete_task(self, task_number):
        try:
            removed_task = self.tasks.pop(task_number - 1)
            print(Fore.RED + f'Task "{removed_task}" removed from the list.' + Style.RESET_ALL)
        except IndexError:
            print(Fore.RED + "Invalid task number. Please try again." + Style.RESET_ALL)

def main():
    todo_list = ToDoList()

    while True:
        print("\nOptions:")
        print(Fore.MAGENTA + "1. Add Task" + Style.RESET_ALL)
        print(Fore.MAGENTA + "2. View Tasks" + Style.RESET_ALL)
        print(Fore.MAGENTA + "3. Delete Task" + Style.RESET_ALL)
        print(Fore.MAGENTA + "4. Exit" + Style.RESET_ALL)

        choice = input("Choose an option (1-4): ")

        if choice == '1':
            task = input("Enter the task: ")
            todo_list.add_task(task)
        elif choice == '2':
            todo_list.view_tasks()
        elif choice == '3':
            task_number = int(input("Enter task number to delete: "))
            todo_list.delete_task(task_number)
        elif choice == '4':
            print(Fore.YELLOW + "Exiting the program." + Style.RESET_ALL)
            break
        else:
            print(Fore.RED + "Invalid option. Please try again." + Style.RESET_ALL)

if __name__ == "__main__":
    main()
