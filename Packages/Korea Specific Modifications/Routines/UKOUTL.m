UKOUTL ; OSE/SMH - Korean Language Utilities;Oct 31, 2018@10:55
 ;;0.0;KOREA SPECIFIC MODIFICATIONS TO VISTA;;
 ; (c) Sam Habiel 2018
 ; Licensed under Apache 2.0
 ;
FMTE(Y,%F) ; External Dates
 ; https://en.wikipedia.org/wiki/Date_and_time_notation_in_South_Korea
 ; But, in the end, I just followed what Windows does
 ; Code below is modeled after $$FMTE^DILIBF
 N %T,%R
 S %T="."_($E($P(Y,".",2)_"000000",1,7))
 S %R=1700+$E(Y,1,3)
 I $E(Y,4,5) S %R=%R_"-"_$E(Y,4,5)
 I $E(Y,6,7) S %R=%R_"-"_$E(Y,6,7)
 D TM^DILIBF
 Q %R
