DGPFAA1 ;ALB/RPM - PRF ASSIGNMENT VALIDATION DATA ; 02/06/03
 ;;5.3;Registration;**425,951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/sgm - Jul 13, 2018 17:20
 ;
 ; XREF+off = ;;p3;p4;p5;p6;p7  for ^DD(26.13)
 ;     p3=array node name          p4=field#
 ;     p5=required param           p7=description
 ;     p6=0 for single value field, 1 for wp fields
 ;
 ; XREF+off = ;;p3;p4;p5;p6;p7  for ^DD(26.131)
 ;     p3=array node name          p4=field#
 ;     p5=required param           p7=description
 ;     p6=0 for single value field, 1 for wp fields
 ;
XREF ;
 ;;DFN;.01;1;0;patient IEN
 ;;FLAG;.02;1;0;pointer to 26.11 or 26.15
 ;;STATUS;.03;1;0;active/inactive
 ;;OWNER;.04;1;0;site that controls the assignment
 ;;ORIGSITE;.05;1;0;site that created the assignment
 ;;REVIEWDT;.06;0;0;review date
 ;;NARR;1;1;1;assignment narrative
 ;;
 ;
DBRS ;  only appropriate for Category I Behavioral Assignments
 ;;DBRS#;.01;0;0;DBRS number
 ;;DBRS OTHER;.02;0;0;short description
 ;;DBRS DATE;.03;0;0;date DBRS record created
 ;;DBRS SITE;.04;0;0;site that created DBRS record
