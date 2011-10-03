ONCOHELP ;Hines OIFO/GWB - Misellaneous HELP ;5/2/92
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
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
