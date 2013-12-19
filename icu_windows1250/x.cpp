#include <unicode/ucnv.h>
#include <string>
#include <iostream>

// string fix_encoding()  string   windows-1250 --> utf-8


int main() {
        using std::string;
        using std::endl;
        using std::cout;

        string bad = "Pawe\b3"; // Paweł

//      Pawe� 

int znak = (int) bad[ i ];
if (znak == 179) dodać "\305\202"

        // std::map 

        string exp= "Pawe\305\202"; // UTF-8

        cout << "bad=" << bad << endl;
        cout << "exp=" << exp<< endl;


                        UConverter * converter;
                        UErrorCode err = U_ZERO_ERROR;
                        converter = ucnv_open( "8859-1", &err );
                        if ( U_SUCCESS( err ) )
                        {
                                        // ...
                                        ucnv_close( converter );
                        }
}

