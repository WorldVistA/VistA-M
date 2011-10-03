LRBARB ;DALOI/JMC - INTERMEC 4000 Series 10 part label format ;8/29/94 12:36
 ;;5.2;LAB SERVICE;**161,218**;Sep 27, 1994
 ; This routine will program the Intermec 4000 series for a 10 part 2.5X4.0 in
 ; label which can be used with LRLABELB routine to print a 10 part
 ; accession label which includes barcoded accession labels.
 ;
FMT ;
 U IO
 ;
 D INIT^LRBARA
 ;
 I LRFMT=12 D BAR
 I LRFMT=13 D BAR1
 ;
 D TERM^LRBARA
 Q
 ;
BAR ; Programs format for 10-part old style.
 ;
 ; Accession number
 W STX,"F",LRFMT,";H0;o0,176;f1;c2;h2;w1;d0,14;",ETX
 ;
 ; Collection date
 W STX,"F",LRFMT,";H1;o35,183;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; collection sample - tube
 W STX,"F",LRFMT,";H2;o89,140;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; Patient name
 W STX,"F",LRFMT,";H3;o89,1;f0;c2;h2;w1;d0,21;",ETX
 ;
 ; Patient identifier - SSN
 W STX,"F",LRFMT,";H4;o89,37;f0;c2;h1;w1;d0,11;",ETX
 ;
 ; Patient location
 W STX,"F",LRFMT,";H5;o260,37;f0;c2;h1;w1;d0,9;",ETX
 ;
 ; Barcoded specimen identifier
 W STX,"F",LRFMT,";B6;o93,59;f0;c0,1;h60;w2;d0,5;",ETX
 ;
 ; order#
 W STX,"F",LRFMT,";H7;o89,125;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; List of tests
 W STX,"F",LRFMT,";H8;o89,157;f0;c2;h2;w1;d0,22;",ETX
 ;
 ; Urgency - STAT
 W STX,"F",LRFMT,";H9;o278,133;f0;c0;h2;w3;b1;d0,4;",ETX
 ;
 ; 1-small label/acc#
 W STX,"F",LRFMT,";H10;o6,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 1-small label/top
 W STX,"F",LRFMT,";H11;o6,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 1-ll label/acc#
 W STX,"F",LRFMT,";H12;o6,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 1-ll label/name
 W STX,"F",LRFMT,";H13;o6,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 1-ll label/ssn
 W STX,"F",LRFMT,";H14;o6,380;f0;c2;h1;w1;d0,11;",ETX
 ;
 ; 1-ll label/date
 W STX,"F",LRFMT,";H15;o6,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 1-ll label/test
 W STX,"F",LRFMT,";H16;o6,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-ml/acc#
 W STX,"F",LRFMT,";H17;o202,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-ml/top
 W STX,"F",LRFMT,";H18;o202,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-ll label acc#
 W STX,"F",LRFMT,";H19;o202,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-ll label/name 
 W STX,"F",LRFMT,";H20;o202,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-ll label/ssn
 W STX,"F",LRFMT,";H21;o202,380;f0;c2;h1;w1;d0,11;",ETX
 ;
 ; 2-ll label/date
 W STX,"F",LRFMT,";H22;o202,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-ll label/test
 W STX,"F",LRFMT,";H23;o202,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-tr label/acc#
 W STX,"F",LRFMT,";H24;o400,1;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-tr label/date
 W STX,"F",LRFMT,";H25;o400,35;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-tr label/tube
 W STX,"F",LRFMT,";H26;o400,55;f0;c2;h1;w1;d0,30;",ETX
 ;
 ; 2-tr label/name
 W STX,"F",LRFMT,";H27;o475,79;f0;c2;h2;w1;d0,21;",ETX
 ;
 ; 2-tr label/ssn
 W STX,"F",LRFMT,";H28;o475,110;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 2-tr label/location
 W STX,"F",LRFMT,";H29;o655,133;f0;c2;h1;w1;d0,9;",ETX
 ;
 ; 2-tr label/order#
 W STX,"F",LRFMT,";H30;o400,133;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-tr label/test
 W STX,"F",LRFMT,";H31;o400,157;f0;c2;h2;w1;d0,22;",ETX
 ;
 ; 2-tr label/stat
 W STX,"F",LRFMT,";H32;o668,35;f0;c0;h3;w3;b1;d0,4;",ETX
 ;
 ; 3-mr label/acc#
 W STX,"F",LRFMT,";H33;o405,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-mr label/top
 W STX,"F",LRFMT,";H34;o405,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 3-br label/acc#
 W STX,"F",LRFMT,";H35;o405,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-br label/name
 W STX,"F",LRFMT,";H36;o405,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-br label/ssn
 W STX,"F",LRFMT,";H37;o405,380;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 3-br label/date
 W STX,"F",LRFMT,";H38;o405,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 3-br label/test
 W STX,"F",LRFMT,";H39;o405,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 4-mr label/acc#
 W STX,"F",LRFMT,";H40;o605,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 4-mr label/top
 W STX,"F",LRFMT,";H41;o605,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 3-br label/acc#
 W STX,"F",LRFMT,";H42;o605,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-br label/name
 W STX,"F",LRFMT,";H43;o605,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-br label/ssn
 W STX,"F",LRFMT,";H44;o605,380;f0;c2;h1;w1;d0,11;",ETX
 ;
 ; 3-br label/date
 W STX,"F",LRFMT,";H45;o605,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 3-br label/test
 W STX,"F",LRFMT,";H46;o605,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 Q
 ;
BAR1 ; Program format for 10-part label using multiple barocde symbologies/specimen UID.
 ;
 ;
 ; Acc#
 W STX,"F",LRFMT,";H0;o108,140;f0;c2;h1;w1;d0,22;",ETX
 ;
 ; Date
 W STX,"F",LRFMT,";H1;o3,140;f0;c2;h1;w1;d0,8;",ETX
 ;
 ; Tube
 W STX,"F",LRFMT,";H2;o178,158;f0;c2;h1;w1;d0,15;",ETX
 ;
 ; Name
 W STX,"F",LRFMT,";H3;o6,1;f0;c2;h2;w1;d0,21;",ETX
 ;
 ; SSN
 W STX,"F",LRFMT,";H4;o6,35;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; Location
 W STX,"F",LRFMT,";H5;o170,35;f0;c2;h1;w1;d0,15;",ETX
 ;
 ; Human-readable ID
 W STX,"F",LRFMT,";H6;o3,120;f0;c2;h1;w1;d0,15;",ETX
 ;
 ; Patient info (infection warning)
 W STX,"F",LRFMT,";H7;o145,120;f0;c2;h1;w1;b1;d0,20;",ETX
 ;
 ; Order#
 W STX,"F",LRFMT,";H8;o3,158;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; Tests
 W STX,"F",LRFMT,";H9;o3,175;f0;c2;h1;w1;d0,32;",ETX
 ;
 ; Urgency
 W STX,"F",LRFMT,";H10;o278,1;f0;c0;h3;w3;b0;d0,4;",ETX
 ;
 ; Urgency (reverse field)
 W STX,"F",LRFMT,";H11;o278,1;f0;c0;h3;w3;b1;d0,4;",ETX
 ;
 ; 1-ML Label/Acc#
 W STX,"F",LRFMT,";H12;o6,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 1-ML Label/Date
 W STX,"F",LRFMT,";H13;o6,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 1-LL Label/Acc#
 W STX,"F",LRFMT,";H14;o6,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 1-LL Label/Name
 W STX,"F",LRFMT,";H15;o6,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 1-LL Label/SSN
 W STX,"F",LRFMT,";H16;o6,380;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 1-LL Label/Date
 W STX,"F",LRFMT,";H17;o6,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 1-LL Label/Test
 W STX,"F",LRFMT,";H18;o6,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-ML/Acc#
 W STX,"F",LRFMT,";H19;o202,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-ML/Date
 W STX,"F",LRFMT,";H20;o202,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-LL Label/Acc#
 W STX,"F",LRFMT,";H21;o202,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-LL Label/Name
 W STX,"F",LRFMT,";H22;o202,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-LL Label/SSN
 W STX,"F",LRFMT,";H23;o202,380;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 2-LL Label/Date
 W STX,"F",LRFMT,";H24;o202,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-LL Label/Test
 W STX,"F",LRFMT,";H25;o202,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 2-TR Label/Name
 W STX,"F",LRFMT,";H26;o405,1;f0;c2;h2;w1;d0,21;",ETX
 ;
 ; 2-TR Label/SSN
 W STX,"F",LRFMT,";H27;o405,35;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 2-TR Label/Location
 W STX,"F",LRFMT,";H28;o570,35;f0;c2;h1;w1;d0,15;",ETX
 ;
 ; 2-TR Label/Human-readable ID
 W STX,"F",LRFMT,";H29;o405,120;f0;c2;h1;w1;d0,15;",ETX
 ;
 ; 2-TR Label/Patient info (infection warning)
 W STX,"F",LRFMT,";H30;o545,120;f0;c2;h1;w1;b1;d0,20;",ETX
 ;
 ; 2-TR Label/Tube
 W STX,"F",LRFMT,";H31;o580,158;f0;c2;h1;w1;d0,15;",ETX
 ;
 ; 2-TR Label/Acc#
 W STX,"F",LRFMT,";H32;o515,140;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-TR Label/Date
 W STX,"F",LRFMT,";H33;o405,140;f0;c2;h1;w1;d0,9;",ETX
 ;
 ; 2-TR Label/Order#
 W STX,"F",LRFMT,";H34;o405,158;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 2-TR Label/Test
 W STX,"F",LRFMT,";H35;o405,175;f0;c2;h1;w1;d0,32;",ETX
 ;
 ; 2-TR Label/Urgency
 W STX,"F",LRFMT,";H36;o675,1;f0;c0;h3;w3;b0;d0,4;",ETX
 ;
 ; 2-TR Label/Urgency (reverse field)
 W STX,"F",LRFMT,";H37;o675,1;f0;c0;h3;w3;b1;d0,4;",ETX
 ;
 ; 3-MR Label/Acc#
 W STX,"F",LRFMT,";H38;o405,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-MR Label/Date
 W STX,"F",LRFMT,";H39;o405,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 3-BR Label/Acc#
 W STX,"F",LRFMT,";H40;o405,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-BR Label/Name
 W STX,"F",LRFMT,";H41;o405,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 3-BR Label/SSN
 W STX,"F",LRFMT,";H42;o405,380;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 3-BR Label/Date
 W STX,"F",LRFMT,";H43;o405,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 3-BR Label/Test
 W STX,"F",LRFMT,";H44;o405,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 4-MR Label/Acc#
 W STX,"F",LRFMT,";H45;o605,219;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 4-MR Label/Date
 W STX,"F",LRFMT,";H46;o605,267;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 4-BR Label/Acc#
 W STX,"F",LRFMT,";H47;o605,311;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 4-BR Label/Name
 W STX,"F",LRFMT,";H48;o605,345;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; 4-BR Label/SSN
 W STX,"F",LRFMT,";H49;o605,380;f0;c2;h1;w1;d0,12;",ETX
 ;
 ; 4-BR Label/Date
 W STX,"F",LRFMT,";H50;o605,406;f0;c2;h1;w1;d0,14;",ETX
 ;
 ; 4-BR Label/Test
 W STX,"F",LRFMT,";H51;o605,438;f0;c2;h2;w1;d0,14;",ETX
 ;
 ; Code 39 (first 1x2 label)
 W STX,"F",LRFMT,";B52;o15,55;f0;c0,3;h60;i0;r2;w1;d0,10;",ETX
 ;
 ; Code 39 (second 1x2 label)
 W STX,"F",LRFMT,";B53;o417,55;f0;c0,3;h60;i0;r2;w1;d0,10;",ETX
 ;
 ; Code 39/check digit (first 1x2 label)
 W STX,"F",LRFMT,";B54;o15,55;f0;c0,4;h60;i0;r2;w1;d0,10;",ETX
 ;
 ; Code 39/check digit (second 1x2 label)
 W STX,"F",LRFMT,";B55;o417,55;f0;c0,4;h60;i0;r2;w1;d0,10;",ETX
 ;
 ; Code 128 (first 1x2 label)
 W STX,"F",LRFMT,";B56;o15,55;f0;c6,0,0;h60;i0;r2;w1;d0,15;",ETX
 ;
 ; Code 128 (second 1x2 label)
 W STX,"F",LRFMT,";B57;o417,55;f0;c6,0,0;h60;i0;r2;w1;d0,15;",ETX
 ;
 Q
