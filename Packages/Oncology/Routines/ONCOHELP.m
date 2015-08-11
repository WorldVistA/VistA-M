ONCOHELP ;Hines OIFO/GWB - Miscellaneous Help ;5/2/92
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
DPD ;DRINKS PER DAY
 W !?5,"Enter the amount of alcohol consumed per day in whiskey equivalents"
 W !?10,"Note-> One whiskey is equivalent to 10.24 grams of alcohol",!!?15,"-  12 ounces of beer is equivalent to one whiskey"
 W !?15,"-   4 ounces of wine is equivalent to one whiskey",!?15,"-   1 ounce of vodka, scotch, etc. is equivalent to one whiskey"
 Q
RAD ;RADIATION Conversion
 W !?10,"Enter the TOTAL amount of Radiation given",!
 W !?10,"1 cGy = 1 RAD     1Gy = 100 RADs",!
 Q
CLK ;CONTACT LOOKUP
 ;ENTER with ONCOX=1,2,3,4,5,6
 I X="?" S X="" Q  ;Q:X="?"
 S X="??",DIC="^ONCO(165,",D="B"_ONCOX,DIC(0)="EZ" D IX^DIC
 Q
 ;
BP ;BIOPSY PROCEDURE (165.5,141)
 D BPGUCHK^ONCOTNE
 I BPSITE="" Q
 W !?3,"Select from the following list:",!
 F XBP=0:0 S XBP=$O(^ONCO(164,BPSITE,"BP5",XBP)) Q:XBP'>0  W !?6,$P($G(^ONCO(164,BPSITE,"BP5",XBP,0)),U,2),?12,$P($G(^ONCO(164,BPSITE,"BP5",XBP,0)),U,1)
 K XBP
 Q
 ;
DTFLGHLP ;XECUTABLE HELP CODE FOR DATE FLAG FIELDS (165.5,999.1-999.25)
 ; ONCITM = THE NAACCR ITEM # ASSOCIATED WITH THE FIELD SET IN THE ^DD
 ;
 I ONCITM=581!(ONCITM=1751) D 12,BLNK K ONCITM Q
 I ONCITM=1201!(ONCITM=1251)!(ONCITM=1271)!(ONCITM=1281)!(ONCITM=1861)!(ONCITM=3171)!(ONCITM=3181) D 10,11,12,15,BLNK K ONCITM Q
 D 10,11,12,15,BLNK
 K ONCITM Q
 ;
10 W !?5,"10 No information whatsoever can be inferred from this exceptional value" Q
11 W !?5,"11 No proper value is applicable in this context" Q
12 W !?5,"12 A proper value is applicable but not known; date is unknown" Q
15 W !?5,"15 Information is not available now but is expected to be available later" Q
BLNK W !?5,"Leave blank if a valid date value is provided",! Q
