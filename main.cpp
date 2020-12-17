#include <iostream>
#include <config.h>

#ifdef USE_MYMATH
 #include "math/MathFunctions.h"
#else
 #include "math.h"
#endif

using namespace std;

namespace A
{
    int a = 100;
    namespace B            //嵌套一个命名空间B
    {
        int a =20;
    }
}

int main() {
    std::cout << "Hello, World!" << std::endl;
	
	std::cout << A::a << std::endl;
	std::cout << A::B::a << std::endl;
	
#ifdef USE_MYMATH
	std::cout << osquery::abcd << std::endl;
	
	auto rf = new osquery::RegistryFactory();
	std::cout << rf->add(3, 5) << std::endl;
	
	osquery::RegistryFactory rfobj;
	std::cout << rfobj.add(32, 5) << std::endl;
	
    std::cout << "Now we use our own Math library." << endl;
    double result = rfobj.power(3, 4);
    std::cout << result << endl;
#else
    std::cout << "Now we use the standard library." << endl;
    double result = pow(3, 4);
    std::cout << result << endl;
#endif
	
    return 0;
}
