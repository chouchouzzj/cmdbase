#include <iostream>
#include <config.h>

#ifdef USE_MYMATH
 #include "math/MathFunctions.h"
#else
 #include "math.h"
#endif

#include <gflags/gflags.h>

using namespace std;

namespace A
{
    int a = 100;
    namespace B            //嵌套一个命名空间B
    {
        int a =20;
    }
}

DEFINE_int32(num_1, 3, "num one");
DEFINE_int32(num_2, 4, "num two");


int main(int argc, char** argv) {
    std::cout << "Hello, World!" << std::endl;
	
	std::cout << A::a << std::endl;
	std::cout << A::B::a << std::endl;

	// 解析gflags参数，只需要1行代码
	gflags::ParseCommandLineFlags(&argc, &argv, true);
	int num_1 = FLAGS_num_1;
	int num_2 = FLAGS_num_2;

#ifdef USE_MYMATH
	std::cout << osquery::abcd << std::endl;
	
	auto rf = new osquery::RegistryFactory();
	std::cout << rf->add(num_1, num_2) << std::endl;
	
	osquery::RegistryFactory rfobj;
	std::cout << rfobj.add(num_1, num_2) << std::endl;
	
    std::cout << "Now we use our own Math library." << endl;
    double result = rfobj.power(num_1, num_2);
    std::cout << result << endl;
#else
    std::cout << "Now we use the standard library." << endl;
    double result = pow(3, 4);
    std::cout << result << endl;
#endif
	
    return 0;
}
