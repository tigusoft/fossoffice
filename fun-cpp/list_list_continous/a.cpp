#include <iostream>
#include <list>
#include <vector>
#include <set>
#include <algorithm>
using std::set;
using std::list;
using std::vector;
using std::cout;
using std::endl;
using std::move;

int main() {
	set<int> in{9,2,1,7,5,6,10,11,3,15,17,16,12};	// 1,2,3   5,6,7  10,11,12  15,16,17
	list<set<int>> A(1);
	for(auto i : in) { if ((A.front().size()) && (!( *(A.back().cend()) + 1 == i))) { A.resize(A.size()+1); } A.back().insert(i); }
	for(auto t : A) { for (auto i: t) cout<<i<<' ';  cout<<"; "; } cout << endl;
}

	//list<set<int>> A(1); set<int> C; int p; size_t n=0;
	//for(auto i : in) { if ((n++) && (!(p+1==i))) A.resize(A.size()+1); A.back().insert(p=i); }
	
	//for(auto i : in) { if ((A.front().size()) && (!( *(A.back().cend()) + 1 == i))) { A.resize(A.size()+1); } A.back().insert(i); }
