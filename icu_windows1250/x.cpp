#include <unicode/ucnv.h>
#include <string>
#include <iostream>

// string fix_encoding()  string   windows-1250 --> utf-8


int main() {
        using std::string;
        using std::endl;
        using std::cout;

// http://www.binaryhexconverter.com/decimal-to-hex-converter
// ł 179 B3
// Ć 198 C6
// ć 230 E6

        //string bad = "a\b3"; // Paweł
        string bad = "a\xC6\xE6"; // aĆć
				//Marmolada. a\b3\b3\b3a."; 

//      Pawe� 

//int znak = (int) bad[ i ];
//if (znak == 179) dodać "\305\202"

        // std::map 

        string exp= "a\305\202"; // UTF-8
        cout << "bad=" << bad << endl;
        cout << "exp=" << exp<< endl;

		UConverter * converter;
		UErrorCode err = U_ZERO_ERROR;
		converter = ucnv_open( "windows-1250", &err );
		size_t len=0;

		if ( U_SUCCESS( err ) )
		{
			// http://www.icu-project.org/apiref/icu4c/ucnv_8h.html#a1493c21231f237e6197c027229389ff8
	/* Parameters:
    cnv	the converter object to be used (ucnv_resetToUnicode() will be called)
    src	the input codepage string
    srcLength	the input string length, or -1 if NUL-terminated
    dest	destination string buffer, can be NULL if destCapacity==0
    destCapacity	the number of UChars available at dest
    pErrorCode	normal ICU error code; common error codes that may be set by this function include U_BUFFER_OVERFLOW_ERROR, U_STRING_NOT_TERMINATED_WARNING, U_ILLEGAL_ARGUMENT_ERROR, and conversion errors

Returns:
    the length of the output string, not counting the terminating NUL; if the length is greater than destCapacity, then the string will not fit and a buffer of the indicated length would need to be passed in 
*/

		int32_t destCapacity = bad.size()+1;  // +1 just to be sure
		UChar* dest = new UChar[destCapacity];
		len = ucnv_toUChars(converter, dest,	destCapacity,   bad.c_str(),  bad.size(),  &err);
		cout << "Converted, len="<<len<<endl;
		cout << "String is:" << dest << endl;
//		for (int32_t i=0; i<len; ++i) cout << (char)dest[i] << ",";
//		cout<<endl;
		for (int32_t i=0; i<len; ++i) cout << (int)(unsigned char)dest[i] << ", ";
		cout<<endl;

		UErrorCode err2 = U_ZERO_ERROR;
		UConverter * converter2;
		converter2 = ucnv_open("UTF-8", &err );
		size_t len2=0;
		if ( U_SUCCESS( err2 ) ) {
			int32_t dest2Capacity =  (len+1) * 8*2;			// for worst case, 8 octet encoded, surrogate chars? TODO optimize
			string dest2( dest2Capacity , 'X' ); 
			cout << "String is:" << dest2 << endl;
			char* dest2_as_sz = & dest2.at(0);
			len2 = ucnv_fromUChars(converter2, dest2_as_sz,  dest2Capacity,   dest,  -1,  &err2);	
			ucnv_close( converter2 );

			cout << "Converted, len2="<<len2<<endl;
			cout << "String is: " << dest2 << endl;
			for (int32_t i=0; i<len2; ++i) cout << (int)(unsigned char)dest2[i] << ", ";
		}

	} else cout << "Failed to open cov" << endl;
	cout << endl;

}


