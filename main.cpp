#include <iostream>
#include "math/MathFunctions.h"
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
	std::cout << osquery::abcd << std::endl;
	auto rf = new osquery::RegistryFactory();
	std::cout << rf->add(3, 5) << std::endl;
	osquery::RegistryFactory rfobj;
	std::cout << rfobj.add(32, 5) << std::endl;
	
    return 0;
}
