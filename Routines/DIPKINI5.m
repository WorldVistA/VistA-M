DIPKINI5 ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K ^UTILITY("DIF",$J) S DIFRDIFI=1 F I=1:1:2 S ^UTILITY("DIF",$J,DIFRDIFI)=$T(IXF+I),DIFRDIFI=DIFRDIFI+1
 Q
IXF ;;DIPK (PACKAGE FILE INIT)^DIPK
 ;;9.4I;PACKAGE;^DIC(9.4,;0;y;y;;n;;;n
 ;;
