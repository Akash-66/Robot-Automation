import random

#print("Hello World")

"""
class Tutorial:
    def __init__(self,name,age):
        self.name = name
        self.age = age


obj = Tutorial("Akash",27)
print(obj.name)
print(obj.age)
"""

def variableTutorial():
    x=5
    y="Akash"
    print("Declaring Variable = ",x)
    print("Declaring Variable = ",y)

    x=int(x)
    y=str(y)
    print("Casting Value = ", x)
    print("Casting Value = ",y)

    print("Checking Type = ", type(x))
    print("Checking Type = ", type(y))

    #Single line multiple declaration

    a,b,c = "Akash","Anjani",3
    print("3 value assigned in single line = ",a,b,c)
    listValues=["Anjani","Akash",4]
    d,e,f = listValues
    print(f"Value assigned via list {listValues} of size 3 in 3 different variables = ",d,e,f)
    print("Concat String = ", a+b+d+e)


def numbersTutorial():
    x = 1  # int
    y = 2.8  # float
    z = 1j  # complex

    print(f"Convert int {x} into float = ",float(x))
    print(f"Convert float {y} into int", int(y))
    print(f"Convert float {y} into complex", complex(y))

    #Random numbers
    print("Random numbers = ",random.randrange(1,10))

def stringTutorials():
    str = "Akash Kesarwani"
    print(f"Printing character from string --> {str} = ",str[1])
    for x in str:
        print("looping value = ",x)
    print("String lenght is = ",len(str))

    print("check given string is present in original string")
    if "Kesarwani" in str:
        print(f"Yes, Kesarwani is present in {str}")
    else:
        print(f"No, Kesarwani is present in {str}")

    #Slicing syntax
    print("Slicing String = ",str[2:5])
    print("Slicing String = ", str[:5])
    print("Slicing String = ", str[6:])
    print("Negative Slicing String = ", str[-6:-1])

    #String Modification
    print("Upper Case = ",str.upper())
    print("Lower Case = ",str.lower())
    print("Remove whitespace = ", str.strip())
    print("Replace String = ",str.replace('a','z'))
    print("Splitting  = ",str.split(" "))

#variableTutorial()
#numbersTutorial()
#stringTutorials()