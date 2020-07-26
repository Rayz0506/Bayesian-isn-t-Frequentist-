import math
import random

print("Please follow the system prompts.")
print("LET's START!")
print("Please provide the bitcoin (BC) rate in Canadian dollars (CAD)$")
rate = float(input("How many CAD$ is 1 BC? ==> "))
print("")

### A

print("Do you want to do calculation (a) ? ")
question = input("Type a for doing calculation (a) and anything else otherwise ==> ")
if ('a' == question):
    print("CALCULATION (a)")
    wdc = int(input("Please provide a number of WordCoins : "))
    byc = int(input("Please provide a number of Bytecoins : "))
    btc = int(input("Please provide a number of Bitcoins : "))
    total = wdc * 32 + byc * 8 + btc
    print("The equivalent to the coins you indicated is: ", total, " BC")
    print("(Recall:  1 WC = 32 BC, 1 BYC = 8 BC)")
    print("TRACE  - the rate is ", float(rate))
    print(total, " BC corresponds to ", float(rate) * total, " CAD$")

### B
print("CALCULATION (b)")
amount = float(input("Please type the amount in CAD$ ==> "))
print("The coins that you can get with", amount, "are:")
btc = int(amount / rate)
wdc = int(btc / 32)
print("--  ", wdc, " wordcoins,")
byc = int((btc - wdc * 32) / 8)
print("--  ", byc, " bytecoins and")
btc = btc - wdc * 32 - byc * 8
print("--  ", btc, " bitcoins")
rem = amount % rate
print("and your change is ", rem)
print("Calculation and printing of (b) is done!")

### C
print("CALCULATION (c)")
secret = ""
if (btc % 2 == 0):
    print("TRACE the number of bitcoins in (b) is even")
    secret += "$$"
else:
    print("TRACE the number of bitcoins in (b) is odd")
    secret += "$"
    
print("TRACE the square root of the total money amount (", amount, ") is: ", math.sqrt(amount))
secret += "**" + "W" * wdc + "**" + "B" * byc + "**" + str(int(math.sqrt(amount)))
print("TRACE the string until and including the int square root is: ", secret)
length = len(secret)
print("TRACE the length of the string so far is: ", length)
if (length % 2 == 0):
    print("TRACE the length so far is even")
    secret += "2"
else:
    print("TRACE the length so far is odd")
    secret += "1"
first_dig = int((math.sqrt(amount) - int(math.sqrt(amount))) * 10)
print("TRACE the digit after the decimal point in the square root is: ", first_dig)
rand = random.randint(0, first_dig)
print("TRACE a random number between 0 and first_decimal is: ", rand)
if (rand == 0):
    print("TRACE there will not be exclamation signs, the random number is 0")
else:
    secret += rand * "!"  
print("The final secret code string is: ", secret)

print("END OF THE PROGRAM! BYE!")
