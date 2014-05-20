#include <iostream>
#include <fstream>
#include <string>
#include <list>
#include <vector>
#include <set>
#include <algorithm>

using std::string;
using std::set;
using std::list;
using std::vector;
using std::cout;
using std::endl;
using std::move;

int main() {
	cout << "Hello world" << endl;


	std::ifstream plik("var/mempo/out");

	while (1) {
		
		string line;

		if (plik.eof()) break; // end of file - do not wait for now XXX
		while (plik.eof()) { }
		getline(plik,line);

		cout << "[" << line <<"]" << endl;
	}
}

