PSULRHLI ;HCIOFO/BH - Post install for PBM 3 enhancements ; 5/15/04 3:10p
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;No DBIA's required
 ;
DTE ; Sets install date into file 59.91
 ;
 N FDA
 S FDA(59.91,"+1,",.01)=$P(DT,".",1)
 D UPDATE^DIE("","FDA",)
 ;
 Q
