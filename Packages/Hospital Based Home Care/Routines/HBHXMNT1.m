HBHXMNT1 ;VAMC(IRMS)/MJT-HBHC maintenance routine:  reindexes "AD" cross-ref on ^HBHC(631, locates & deletes records in ^HBHC(634 w/pseudo SSNs, calls HBHXMNT2 to produce report(s) of patients w/pseudo SSN ;9403
 ;;1.0;HOSPITAL BASED HOME CARE;**2**;NOV 01, 1993
 W @IOF,"Beginning Post-Initialization Process",!!!,"-  Reindexing ""AD"", Admission Date (#17) field, cross-reference, in HBHC",!,"Patient (#631) file, to clean up possible dangling cross-reference."
 K DA,DIK,^HBHC(631,"AD") S DIK="^HBHC(631,",DIK(1)="17" D ENALL^DIK
 W !!,"""AD"" reindexing complete."
 W !!!,"-  Locating patient records in HBHC Patient (#631) & HBHC Visit (#632) files",!,"that have a pseudo social security number (SSN).  These are invalid for HBHC"
 W !,"purposes.  This routine also locates & deletes any records in the HBHC",!,"Transmit (#634) file containing pseudo SSNs.  Two reports of Patient Names are"
 W !,"printed listing those patients that must be resolved.  See Patch Narrative",!,"for detailed resolution instructions." H 3
 S HBHCDFN=0 F  S HBHCDFN=$O(^HBHC(634,HBHCDFN)) Q:HBHCDFN'>0  D PROCESS
EXIT ; Exit module
 K DA,DIK,HBHCDATA,HBHCDFN,HBHCFORM,HBHCINFO,HBHCPOS
 W !!,"Please select a PRINTER for device.  HBHC will need these Pseudo SSN Reports",!,"to resolve the invalid SSNs."
 D ^HBHXMNT2
 Q
PROCESS ; Process record
 S HBHCINFO=^HBHC(634,HBHCDFN,0),HBHCFORM=$E(HBHCINFO)
 S HBHCPOS=$S(HBHCFORM=3:80,HBHCFORM=5:38,HBHCFORM=6:44,1:34)
 S HBHCDATA=$E(HBHCINFO,HBHCPOS)
 I HBHCDATA="P" K DA,DIK S DIK="^HBHC(634,",DA=HBHCDFN D ^DIK
 Q
