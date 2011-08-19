DVBWCHK ;ISC-Albany.med.va.gov/PKE-check for installed PIMS v5.3; 14-SEP-1993
 ;;V4.0;HINQ;**14**;03/25/92
 ;
 I '$D(^DD(2,0,"VR")) K DIFQ D MES Q
 I ^DD(2,0,"VR")<5.3 K DIFQ D MES Q
 Q
MES W !!,*7,"DVBWCHK...This init should run after PIMS v5.3 is installed" Q
