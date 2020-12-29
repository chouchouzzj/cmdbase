#include "MathFunctions.h"
#include <iostream>
using namespace std;
namespace osquery {
	int abcd = 100;
	RegistryFactory::RegistryFactory(){};
	
	int RegistryFactory::add(int a, int b)
	{
		return a + b;
	}
	double RegistryFactory::power(int a, int b)
	{
		std::cout << "power(a ** b) = ";
		int res = 1;
		for(int i=0;i<b;i++)
			res = res * a;
		return (double)res;
	}
}