# Script 1: Grade classifier

score = int(input("Score: "))

if score >= 80:
    print("A")

elif score >= 70:
    print("B")

elif score >= 60:
    print("C")

elif score >= 50:
    print("D")

else:
    print("F")


# Script 2: Salary category
salary = int(input("Salary: "))

if salary >= 70000:
    print("High Income")

elif salary >= 35000:
    print("Middle Income")

else:
    print("Low Income")
