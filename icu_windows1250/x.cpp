#include <unicode/ucnv.h>
#include <string>
#include <stdexcept>
#include <iostream>

// string fix_encoding()  string   windows-1250 --> utf-8

using std::string;
using std::endl;
using std::cout;

int convert_windows1250_to_utf8() {
	UConverter * converter;
	UErrorCode err = U_ZERO_ERROR;
	converter = ucnv_open( "windows-1250", &err );

	if ( U_SUCCESS(err) )	{
		// http://www.icu-project.org/apiref/icu4c/ucnv_8h.html#a1493c21231f237e6197c027229389ff8

		size_t len=0;
		int32_t destCapacity = bad.size()+1;  // +1 just to be sure
		UChar* dest = new UChar[destCapacity];
		len = ucnv_toUChars(converter, dest,	destCapacity,   bad.c_str(),  bad.size(),  &err);
		if (!U_SUCCESS(err2)) throw std::runtime_error("Can not convert.");
		// for (int32_t i=0; i<len; ++i) cout << (int)(unsigned char)dest[i] << ", ";  		cout<<endl;

		UErrorCode err2 = U_ZERO_ERROR;
		UConverter * converter2;
		converter2 = ucnv_open("UTF-8", &err );
		size_t len2=0;
		if ( U_SUCCESS(err2) ) {
			int32_t dest2Capacity =  (len+1) * 8*2;			// for worst case, 8 octet encoded, surrogate chars? TODO optimize
			std::string dest2( dest2Capacity , 'X' ); 
			cout << "String is:" << dest2 << endl;
			char* dest2_as_sz = & dest2.at(0);
			len2 = ucnv_fromUChars(converter2, dest2_as_sz,  dest2Capacity,   dest,  -1,  &err2);	
			if (!U_SUCCESS(err2)) throw std::runtime_error("Can not convert 2.");
			ucnv_close( converter2 );
				// for (int32_t i=0; i<len2; ++i) cout << (int)(unsigned char)dest2[i] << ", ";  cout<<endl;
		} else throw std::runtime_error("Can not open conv2.");
	} else throw std::runtime_error("Can not open conv.");

	cout << endl;

}


int main() {
	string bad = "Pawe\xB3. a\xC6\xE6"; // aĆć
	cout << convert_windows1250_to_utf8( bad );
}



