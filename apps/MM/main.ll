; ModuleID = 'main.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._cl_platform_id = type opaque
%"class.aocl_utils::scoped_array" = type { %struct._cl_device_id** }
%struct._cl_device_id = type opaque
%struct._cl_context = type opaque
%"class.aocl_utils::scoped_array.0" = type { %struct._cl_command_queue** }
%struct._cl_command_queue = type opaque
%struct._cl_program = type opaque
%"class.aocl_utils::scoped_array.1" = type { %struct._cl_kernel** }
%struct._cl_kernel = type opaque
%"class.aocl_utils::scoped_array.2" = type { %struct._cl_mem** }
%struct._cl_mem = type opaque
%"class.aocl_utils::scoped_array.3" = type { %"class.aocl_utils::scoped_aligned_ptr"* }
%"class.aocl_utils::scoped_aligned_ptr" = type { float* }
%"class.aocl_utils::scoped_array.4" = type { float* }
%"class.aocl_utils::scoped_array.5" = type { i32* }
%"class.aocl_utils::Options" = type { %"class.std::map", %"class.std::vector" }
%"class.std::map" = type { %"class.std::_Rb_tree" }
%"class.std::_Rb_tree" = type { %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl" }
%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl" = type { %"struct.std::less", %"struct.std::_Rb_tree_node_base", i64 }
%"struct.std::less" = type { i8 }
%"struct.std::_Rb_tree_node_base" = type { i32, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl" }
%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl" = type { %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"* }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%union.anon = type { i64, [8 x i8] }
%"class.std::allocator.9" = type { i8 }
%"class.std::__cxx11::basic_stringstream" = type { %"class.std::basic_iostream.base", %"class.std::__cxx11::basic_stringbuf", %"class.std::basic_ios" }
%"class.std::basic_iostream.base" = type { %"class.std::basic_istream.base", %"class.std::basic_ostream.base" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_ostream.base" = type { i32 (...)** }
%"class.std::__cxx11::basic_stringbuf" = type { %"class.std::basic_streambuf", i32, %"class.std::__cxx11::basic_string" }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }
%"class.aocl_utils::scoped_array.12" = type { %struct._cl_event** }
%struct._cl_event = type opaque
%"class.std::allocator.6" = type { i8 }
%"class.__gnu_cxx::new_allocator.7" = type { i8 }
%"struct.std::_Rb_tree_node" = type { %"struct.std::_Rb_tree_node_base", %"struct.__gnu_cxx::__aligned_membuf" }
%"struct.__gnu_cxx::__aligned_membuf" = type { [64 x i8] }
%"class.std::allocator" = type { i8 }
%"struct.std::pair" = type { %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string" }
%"class.__gnu_cxx::new_allocator" = type { i8 }

$_ZN10aocl_utils12scoped_arrayIP13_cl_device_idEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP13_cl_device_idED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP10_cl_kernelEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP10_cl_kernelED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP7_cl_memEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP7_cl_memED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEED2Ev = comdat any

$_ZN10aocl_utils18scoped_aligned_ptrIfEC2Ev = comdat any

$_ZN10aocl_utils18scoped_aligned_ptrIfED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIfEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIfED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIjEC2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIjED2Ev = comdat any

$_ZNK10aocl_utils7Options3getIjEET_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE = comdat any

$_ZN10aocl_utils7OptionsD2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP13_cl_device_idE5resetEPS2_ = comdat any

$_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEixEi = comdat any

$_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEcvPS2_Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEm = comdat any

$_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEm = comdat any

$_ZN10aocl_utils12scoped_arrayIjE5resetEm = comdat any

$_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEm = comdat any

$_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi = comdat any

$_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi = comdat any

$_ZNK10aocl_utils12scoped_arrayIjEixEi = comdat any

$_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi = comdat any

$_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEm = comdat any

$_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi = comdat any

$_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEm = comdat any

$_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi = comdat any

$_ZNK10aocl_utils18scoped_aligned_ptrIfEcvPfEv = comdat any

$_ZN10aocl_utils12scoped_arrayIP9_cl_eventEC2Em = comdat any

$_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEixEi = comdat any

$_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEcvPS2_Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP9_cl_eventED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIfE5resetEm = comdat any

$_ZNK10aocl_utils12scoped_arrayIfEixEi = comdat any

$_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEcvPS2_Ev = comdat any

$_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEcvPS2_Ev = comdat any

$_ZNK10aocl_utils12scoped_arrayIP7_cl_memEcvPS2_Ev = comdat any

$_ZNSt6vectorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev = comdat any

$_ZNSt3mapINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_St4lessIS5_ESaISt4pairIKS5_S5_EEED2Ev = comdat any

$_ZSt8_DestroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_EvT_S7_RSaIT0_E = comdat any

$_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE19_M_get_Tp_allocatorEv = comdat any

$_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev = comdat any

$__clang_call_terminate = comdat any

$_ZSt8_DestroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEvT_S7_ = comdat any

$_ZNSt12_Destroy_auxILb0EE9__destroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEvT_S9_ = comdat any

$_ZSt8_DestroyINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEvPT_ = comdat any

$_ZSt11__addressofINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEPT_RS6_ = comdat any

$_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE13_M_deallocateEPS5_m = comdat any

$_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE12_Vector_implD2Ev = comdat any

$_ZNSt16allocator_traitsISaINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEE10deallocateERS6_PS5_m = comdat any

$_ZN9__gnu_cxx13new_allocatorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE10deallocateEPS6_m = comdat any

$_ZNSaINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEED2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEED2Ev = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EED2Ev = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_eraseEPSt13_Rb_tree_nodeIS8_E = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_beginEv = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE13_Rb_tree_implISC_Lb1EED2Ev = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_S_rightEPSt18_Rb_tree_node_base = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE7_S_leftEPSt18_Rb_tree_node_base = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS8_E = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE15_M_destroy_nodeEPSt13_Rb_tree_nodeIS8_E = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS8_E = comdat any

$_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EEEE7destroyIS9_EEvRSB_PT_ = comdat any

$_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE21_M_get_Node_allocatorEv = comdat any

$_ZNSt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_EE9_M_valptrEv = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEE7destroyISA_EEvPT_ = comdat any

$_ZNSt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_ED2Ev = comdat any

$_ZN9__gnu_cxx16__aligned_membufISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EE6_M_ptrEv = comdat any

$_ZN9__gnu_cxx16__aligned_membufISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EE7_M_addrEv = comdat any

$_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EEEE10deallocateERSB_PSA_m = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEE10deallocateEPSB_m = comdat any

$_ZNSaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_EEED2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEED2Ev = comdat any

$_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEPS2_ = comdat any

$_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEPS2_ = comdat any

$_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEPS2_ = comdat any

$_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEPS2_ = comdat any

$_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEPf = comdat any

$_ZN10aocl_utils12scoped_arrayIfE5resetEPf = comdat any

$_ZN10aocl_utils12scoped_arrayIjE5resetEPj = comdat any

$_ZStorSt13_Ios_OpenmodeS_ = comdat any

$_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEm = comdat any

$_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEPS2_ = comdat any

@platform = dso_local global %struct._cl_platform_id* null, align 8
@num_devices = dso_local global i32 0, align 4
@device = dso_local global %"class.aocl_utils::scoped_array" zeroinitializer, align 8
@__dso_handle = external hidden global i8
@context = dso_local global %struct._cl_context* null, align 8
@queue = dso_local global %"class.aocl_utils::scoped_array.0" zeroinitializer, align 8
@program = dso_local global %struct._cl_program* null, align 8
@kernel = dso_local global %"class.aocl_utils::scoped_array.1" zeroinitializer, align 8
@input_a_buf = dso_local global %"class.aocl_utils::scoped_array.2" zeroinitializer, align 8
@input_b_buf = dso_local global %"class.aocl_utils::scoped_array.2" zeroinitializer, align 8
@output_buf = dso_local global %"class.aocl_utils::scoped_array.2" zeroinitializer, align 8
@A_height = dso_local global i32 2048, align 4
@A_width = dso_local global i32 1024, align 4
@B_height = dso_local constant i32* @A_width, align 8
@B_width = dso_local global i32 1024, align 4
@C_height = dso_local constant i32* @A_height, align 8
@C_width = dso_local constant i32* @B_width, align 8
@input_a = dso_local global %"class.aocl_utils::scoped_array.3" zeroinitializer, align 8
@input_b = dso_local global %"class.aocl_utils::scoped_aligned_ptr" zeroinitializer, align 8
@output = dso_local global %"class.aocl_utils::scoped_array.3" zeroinitializer, align 8
@ref_output = dso_local global %"class.aocl_utils::scoped_array.4" zeroinitializer, align 8
@rows_per_device = dso_local global %"class.aocl_utils::scoped_array.5" zeroinitializer, align 8
@.str = private unnamed_addr constant [3 x i8] c"ah\00", align 1
@.str.11 = private unnamed_addr constant [3 x i8] c"aw\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"bw\00", align 1
@.str.13 = private unnamed_addr constant [54 x i8] c"Matrix sizes:\0A  A: %d x %d\0A  B: %d x %d\0A  C: %d x %d\0A\00", align 1
@.str.14 = private unnamed_addr constant [40 x i8] c"Matrix sizes must be a multiple of %d.\0A\00", align 1
@.str.15 = private unnamed_addr constant [21 x i8] c"Initializing OpenCL\0A\00", align 1
@.str.16 = private unnamed_addr constant [14 x i8] c"Intel(R) FPGA\00", align 1
@.str.17 = private unnamed_addr constant [54 x i8] c"ERROR: Unable to find Intel(R) FPGA OpenCL platform.\0A\00", align 1
@.str.18 = private unnamed_addr constant [14 x i8] c"Platform: %s\0A\00", align 1
@.str.19 = private unnamed_addr constant [20 x i8] c"Using %d device(s)\0A\00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c"  %s\0A\00", align 1
@.str.21 = private unnamed_addr constant [9 x i8] c"main.cpp\00", align 1
@.str.22 = private unnamed_addr constant [25 x i8] c"Failed to create context\00", align 1
@.str.23 = private unnamed_addr constant [9 x i8] c"baseline\00", align 1
@.str.24 = private unnamed_addr constant [16 x i8] c"Using AOCX: %s\0A\00", align 1
@.str.25 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.26 = private unnamed_addr constant [24 x i8] c"Failed to build program\00", align 1
@.str.27 = private unnamed_addr constant [31 x i8] c"Failed to create command queue\00", align 1
@.str.28 = private unnamed_addr constant [11 x i8] c"matrixMult\00", align 1
@.str.29 = private unnamed_addr constant [24 x i8] c"Failed to create kernel\00", align 1
@.str.30 = private unnamed_addr constant [36 x i8] c"Failed to create buffer for input A\00", align 1
@.str.31 = private unnamed_addr constant [36 x i8] c"Failed to create buffer for input B\00", align 1
@.str.32 = private unnamed_addr constant [35 x i8] c"Failed to create buffer for output\00", align 1
@.str.33 = private unnamed_addr constant [11 x i8] c"No devices\00", align 1
@.str.34 = private unnamed_addr constant [27 x i8] c"Generating input matrices\0A\00", align 1
@.str.35 = private unnamed_addr constant [27 x i8] c"Failed to transfer input A\00", align 1
@.str.36 = private unnamed_addr constant [27 x i8] c"Failed to transfer input B\00", align 1
@.str.37 = private unnamed_addr constant [26 x i8] c"Failed to set argument %d\00", align 1
@__const._Z3runv.local_work_size = private unnamed_addr constant [2 x i64] [i64 64, i64 64], align 16
@.str.38 = private unnamed_addr constant [47 x i8] c"Launching for device %d (global size: %d, %d)\0A\00", align 1
@.str.39 = private unnamed_addr constant [24 x i8] c"Failed to launch kernel\00", align 1
@.str.40 = private unnamed_addr constant [23 x i8] c"Kernel Time: %0.3f ms\0A\00", align 1
@.str.41 = private unnamed_addr constant [37 x i8] c"Kernel Time (using event): %0.3f ms\0A\00", align 1
@.str.42 = private unnamed_addr constant [28 x i8] c"\0AThroughput: %0.2f GFLOPS\0A\0A\00", align 1
@.str.43 = private unnamed_addr constant [29 x i8] c"Failed to read output matrix\00", align 1
@.str.44 = private unnamed_addr constant [28 x i8] c"Computing reference output\0A\00", align 1
@.str.45 = private unnamed_addr constant [11 x i8] c"Verifying\0A\00", align 1
@.str.46 = private unnamed_addr constant [18 x i8] c"Verification: %s\0A\00", align 1
@.str.47 = private unnamed_addr constant [5 x i8] c"PASS\00", align 1
@.str.48 = private unnamed_addr constant [5 x i8] c"FAIL\00", align 1
@.str.49 = private unnamed_addr constant [25 x i8] c"Error (L^2-Norm): %0.3g\0A\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_main.cpp, i8* null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idEC2Ev(%"class.aocl_utils::scoped_array"* @device)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array"*)* @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array"* @device to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idEC2Ev(%"class.aocl_utils::scoped_array"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array"*, align 8
  store %"class.aocl_utils::scoped_array"* %this, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array"*, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array", %"class.aocl_utils::scoped_array"* %this1, i32 0, i32 0
  store %struct._cl_device_id** null, %struct._cl_device_id*** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idED2Ev(%"class.aocl_utils::scoped_array"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array"*, align 8
  store %"class.aocl_utils::scoped_array"* %this, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array"*, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idE5resetEPS2_(%"class.aocl_utils::scoped_array"* %this1, %struct._cl_device_id** null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.1() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueEC2Ev(%"class.aocl_utils::scoped_array.0"* @queue)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.0"*)* @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.0"* @queue to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueEC2Ev(%"class.aocl_utils::scoped_array.0"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.0"*, align 8
  store %"class.aocl_utils::scoped_array.0"* %this, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.0"*, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.0", %"class.aocl_utils::scoped_array.0"* %this1, i32 0, i32 0
  store %struct._cl_command_queue** null, %struct._cl_command_queue*** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueED2Ev(%"class.aocl_utils::scoped_array.0"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.0"*, align 8
  store %"class.aocl_utils::scoped_array.0"* %this, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.0"*, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEPS2_(%"class.aocl_utils::scoped_array.0"* %this1, %struct._cl_command_queue** null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.2() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelEC2Ev(%"class.aocl_utils::scoped_array.1"* @kernel)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.1"*)* @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.1"* @kernel to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelEC2Ev(%"class.aocl_utils::scoped_array.1"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.1"*, align 8
  store %"class.aocl_utils::scoped_array.1"* %this, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.1"*, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.1", %"class.aocl_utils::scoped_array.1"* %this1, i32 0, i32 0
  store %struct._cl_kernel** null, %struct._cl_kernel*** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelED2Ev(%"class.aocl_utils::scoped_array.1"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.1"*, align 8
  store %"class.aocl_utils::scoped_array.1"* %this, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.1"*, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEPS2_(%"class.aocl_utils::scoped_array.1"* %this1, %struct._cl_kernel** null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.3() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIP7_cl_memEC2Ev(%"class.aocl_utils::scoped_array.2"* @input_a_buf)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.2"*)* @_ZN10aocl_utils12scoped_arrayIP7_cl_memED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.2"* @input_a_buf to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP7_cl_memEC2Ev(%"class.aocl_utils::scoped_array.2"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.2"*, align 8
  store %"class.aocl_utils::scoped_array.2"* %this, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.2"*, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.2", %"class.aocl_utils::scoped_array.2"* %this1, i32 0, i32 0
  store %struct._cl_mem** null, %struct._cl_mem*** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP7_cl_memED2Ev(%"class.aocl_utils::scoped_array.2"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.2"*, align 8
  store %"class.aocl_utils::scoped_array.2"* %this, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.2"*, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEPS2_(%"class.aocl_utils::scoped_array.2"* %this1, %struct._cl_mem** null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.4() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIP7_cl_memEC2Ev(%"class.aocl_utils::scoped_array.2"* @input_b_buf)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.2"*)* @_ZN10aocl_utils12scoped_arrayIP7_cl_memED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.2"* @input_b_buf to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.5() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIP7_cl_memEC2Ev(%"class.aocl_utils::scoped_array.2"* @output_buf)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.2"*)* @_ZN10aocl_utils12scoped_arrayIP7_cl_memED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.2"* @output_buf to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.6() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEC2Ev(%"class.aocl_utils::scoped_array.3"* @input_a)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.3"*)* @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.3"* @input_a to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEC2Ev(%"class.aocl_utils::scoped_array.3"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.3"*, align 8
  store %"class.aocl_utils::scoped_array.3"* %this, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.3"*, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.3", %"class.aocl_utils::scoped_array.3"* %this1, i32 0, i32 0
  store %"class.aocl_utils::scoped_aligned_ptr"* null, %"class.aocl_utils::scoped_aligned_ptr"** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEED2Ev(%"class.aocl_utils::scoped_array.3"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.3"*, align 8
  store %"class.aocl_utils::scoped_array.3"* %this, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.3"*, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEPS2_(%"class.aocl_utils::scoped_array.3"* %this1, %"class.aocl_utils::scoped_aligned_ptr"* null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.7() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfEC2Ev(%"class.aocl_utils::scoped_aligned_ptr"* @input_b)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_aligned_ptr"*)* @_ZN10aocl_utils18scoped_aligned_ptrIfED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_aligned_ptr"* @input_b to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils18scoped_aligned_ptrIfEC2Ev(%"class.aocl_utils::scoped_aligned_ptr"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  store %"class.aocl_utils::scoped_aligned_ptr"* %this, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %this1, i32 0, i32 0
  store float* null, float** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils18scoped_aligned_ptrIfED2Ev(%"class.aocl_utils::scoped_aligned_ptr"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  store %"class.aocl_utils::scoped_aligned_ptr"* %this, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  invoke void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEPf(%"class.aocl_utils::scoped_aligned_ptr"* %this1, float* null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.8() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEC2Ev(%"class.aocl_utils::scoped_array.3"* @output)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.3"*)* @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.3"* @output to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.9() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIfEC2Ev(%"class.aocl_utils::scoped_array.4"* @ref_output)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.4"*)* @_ZN10aocl_utils12scoped_arrayIfED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.4"* @ref_output to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIfEC2Ev(%"class.aocl_utils::scoped_array.4"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.4"*, align 8
  store %"class.aocl_utils::scoped_array.4"* %this, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.4"*, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.4", %"class.aocl_utils::scoped_array.4"* %this1, i32 0, i32 0
  store float* null, float** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIfED2Ev(%"class.aocl_utils::scoped_array.4"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.4"*, align 8
  store %"class.aocl_utils::scoped_array.4"* %this, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.4"*, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIfE5resetEPf(%"class.aocl_utils::scoped_array.4"* %this1, float* null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init.10() #0 section ".text.startup" {
entry:
  call void @_ZN10aocl_utils12scoped_arrayIjEC2Ev(%"class.aocl_utils::scoped_array.5"* @rows_per_device)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.aocl_utils::scoped_array.5"*)* @_ZN10aocl_utils12scoped_arrayIjED2Ev to void (i8*)*), i8* bitcast (%"class.aocl_utils::scoped_array.5"* @rows_per_device to i8*), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIjEC2Ev(%"class.aocl_utils::scoped_array.5"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.5"*, align 8
  store %"class.aocl_utils::scoped_array.5"* %this, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.5"*, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.5", %"class.aocl_utils::scoped_array.5"* %this1, i32 0, i32 0
  store i32* null, i32** %m_ptr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIjED2Ev(%"class.aocl_utils::scoped_array.5"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.5"*, align 8
  store %"class.aocl_utils::scoped_array.5"* %this, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.5"*, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIjE5resetEPj(%"class.aocl_utils::scoped_array.5"* %this1, i32* null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline norecurse optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #3 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %options = alloca %"class.aocl_utils::Options", align 8
  %ref.tmp = alloca %"class.std::__cxx11::basic_string", align 8
  %ref.tmp1 = alloca %"class.std::allocator.9", align 1
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %ref.tmp4 = alloca %"class.std::__cxx11::basic_string", align 8
  %ref.tmp5 = alloca %"class.std::allocator.9", align 1
  %ref.tmp13 = alloca %"class.std::__cxx11::basic_string", align 8
  %ref.tmp14 = alloca %"class.std::allocator.9", align 1
  %ref.tmp23 = alloca %"class.std::__cxx11::basic_string", align 8
  %ref.tmp24 = alloca %"class.std::allocator.9", align 1
  %ref.tmp33 = alloca %"class.std::__cxx11::basic_string", align 8
  %ref.tmp34 = alloca %"class.std::allocator.9", align 1
  %ref.tmp43 = alloca %"class.std::__cxx11::basic_string", align 8
  %ref.tmp44 = alloca %"class.std::allocator.9", align 1
  %cleanup.dest.slot = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = load i32, i32* %argc.addr, align 4
  %1 = load i8**, i8*** %argv.addr, align 8
  call void @_ZN10aocl_utils7OptionsC1EiPPc(%"class.aocl_utils::Options"* %options, i32 %0, i8** %1)
  call void @_ZNSaIcEC1Ev(%"class.std::allocator.9"* %ref.tmp1) #2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* %ref.tmp, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), %"class.std::allocator.9"* dereferenceable(1) %ref.tmp1)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %call = invoke zeroext i1 @_ZNK10aocl_utils7Options3hasERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %options, %"class.std::__cxx11::basic_string"* dereferenceable(32) %ref.tmp)
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %invoke.cont
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp) #2
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp1) #2
  br i1 %call, label %if.then, label %if.end

if.then:                                          ; preds = %invoke.cont3
  call void @_ZNSaIcEC1Ev(%"class.std::allocator.9"* %ref.tmp5) #2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* %ref.tmp4, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), %"class.std::allocator.9"* dereferenceable(1) %ref.tmp5)
          to label %invoke.cont7 unwind label %lpad6

invoke.cont7:                                     ; preds = %if.then
  %call10 = invoke i32 @_ZNK10aocl_utils7Options3getIjEET_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %options, %"class.std::__cxx11::basic_string"* dereferenceable(32) %ref.tmp4)
          to label %invoke.cont9 unwind label %lpad8

invoke.cont9:                                     ; preds = %invoke.cont7
  store i32 %call10, i32* @A_height, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp4) #2
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp5) #2
  br label %if.end

lpad:                                             ; preds = %entry
  %2 = landingpad { i8*, i32 }
          cleanup
  %3 = extractvalue { i8*, i32 } %2, 0
  store i8* %3, i8** %exn.slot, align 8
  %4 = extractvalue { i8*, i32 } %2, 1
  store i32 %4, i32* %ehselector.slot, align 4
  br label %ehcleanup

lpad2:                                            ; preds = %invoke.cont
  %5 = landingpad { i8*, i32 }
          cleanup
  %6 = extractvalue { i8*, i32 } %5, 0
  store i8* %6, i8** %exn.slot, align 8
  %7 = extractvalue { i8*, i32 } %5, 1
  store i32 %7, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp) #2
  br label %ehcleanup

ehcleanup:                                        ; preds = %lpad2, %lpad
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp1) #2
  br label %ehcleanup81

lpad6:                                            ; preds = %if.then
  %8 = landingpad { i8*, i32 }
          cleanup
  %9 = extractvalue { i8*, i32 } %8, 0
  store i8* %9, i8** %exn.slot, align 8
  %10 = extractvalue { i8*, i32 } %8, 1
  store i32 %10, i32* %ehselector.slot, align 4
  br label %ehcleanup12

lpad8:                                            ; preds = %invoke.cont7
  %11 = landingpad { i8*, i32 }
          cleanup
  %12 = extractvalue { i8*, i32 } %11, 0
  store i8* %12, i8** %exn.slot, align 8
  %13 = extractvalue { i8*, i32 } %11, 1
  store i32 %13, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp4) #2
  br label %ehcleanup12

ehcleanup12:                                      ; preds = %lpad8, %lpad6
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp5) #2
  br label %ehcleanup81

if.end:                                           ; preds = %invoke.cont9, %invoke.cont3
  call void @_ZNSaIcEC1Ev(%"class.std::allocator.9"* %ref.tmp14) #2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* %ref.tmp13, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.11, i64 0, i64 0), %"class.std::allocator.9"* dereferenceable(1) %ref.tmp14)
          to label %invoke.cont16 unwind label %lpad15

invoke.cont16:                                    ; preds = %if.end
  %call19 = invoke zeroext i1 @_ZNK10aocl_utils7Options3hasERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %options, %"class.std::__cxx11::basic_string"* dereferenceable(32) %ref.tmp13)
          to label %invoke.cont18 unwind label %lpad17

invoke.cont18:                                    ; preds = %invoke.cont16
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp13) #2
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp14) #2
  br i1 %call19, label %if.then22, label %if.end32

if.then22:                                        ; preds = %invoke.cont18
  call void @_ZNSaIcEC1Ev(%"class.std::allocator.9"* %ref.tmp24) #2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* %ref.tmp23, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.11, i64 0, i64 0), %"class.std::allocator.9"* dereferenceable(1) %ref.tmp24)
          to label %invoke.cont26 unwind label %lpad25

invoke.cont26:                                    ; preds = %if.then22
  %call29 = invoke i32 @_ZNK10aocl_utils7Options3getIjEET_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %options, %"class.std::__cxx11::basic_string"* dereferenceable(32) %ref.tmp23)
          to label %invoke.cont28 unwind label %lpad27

invoke.cont28:                                    ; preds = %invoke.cont26
  store i32 %call29, i32* @A_width, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp23) #2
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp24) #2
  br label %if.end32

lpad15:                                           ; preds = %if.end
  %14 = landingpad { i8*, i32 }
          cleanup
  %15 = extractvalue { i8*, i32 } %14, 0
  store i8* %15, i8** %exn.slot, align 8
  %16 = extractvalue { i8*, i32 } %14, 1
  store i32 %16, i32* %ehselector.slot, align 4
  br label %ehcleanup21

lpad17:                                           ; preds = %invoke.cont16
  %17 = landingpad { i8*, i32 }
          cleanup
  %18 = extractvalue { i8*, i32 } %17, 0
  store i8* %18, i8** %exn.slot, align 8
  %19 = extractvalue { i8*, i32 } %17, 1
  store i32 %19, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp13) #2
  br label %ehcleanup21

ehcleanup21:                                      ; preds = %lpad17, %lpad15
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp14) #2
  br label %ehcleanup81

lpad25:                                           ; preds = %if.then22
  %20 = landingpad { i8*, i32 }
          cleanup
  %21 = extractvalue { i8*, i32 } %20, 0
  store i8* %21, i8** %exn.slot, align 8
  %22 = extractvalue { i8*, i32 } %20, 1
  store i32 %22, i32* %ehselector.slot, align 4
  br label %ehcleanup31

lpad27:                                           ; preds = %invoke.cont26
  %23 = landingpad { i8*, i32 }
          cleanup
  %24 = extractvalue { i8*, i32 } %23, 0
  store i8* %24, i8** %exn.slot, align 8
  %25 = extractvalue { i8*, i32 } %23, 1
  store i32 %25, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp23) #2
  br label %ehcleanup31

ehcleanup31:                                      ; preds = %lpad27, %lpad25
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp24) #2
  br label %ehcleanup81

if.end32:                                         ; preds = %invoke.cont28, %invoke.cont18
  call void @_ZNSaIcEC1Ev(%"class.std::allocator.9"* %ref.tmp34) #2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* %ref.tmp33, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.12, i64 0, i64 0), %"class.std::allocator.9"* dereferenceable(1) %ref.tmp34)
          to label %invoke.cont36 unwind label %lpad35

invoke.cont36:                                    ; preds = %if.end32
  %call39 = invoke zeroext i1 @_ZNK10aocl_utils7Options3hasERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %options, %"class.std::__cxx11::basic_string"* dereferenceable(32) %ref.tmp33)
          to label %invoke.cont38 unwind label %lpad37

invoke.cont38:                                    ; preds = %invoke.cont36
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp33) #2
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp34) #2
  br i1 %call39, label %if.then42, label %if.end52

if.then42:                                        ; preds = %invoke.cont38
  call void @_ZNSaIcEC1Ev(%"class.std::allocator.9"* %ref.tmp44) #2
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"* %ref.tmp43, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.12, i64 0, i64 0), %"class.std::allocator.9"* dereferenceable(1) %ref.tmp44)
          to label %invoke.cont46 unwind label %lpad45

invoke.cont46:                                    ; preds = %if.then42
  %call49 = invoke i32 @_ZNK10aocl_utils7Options3getIjEET_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %options, %"class.std::__cxx11::basic_string"* dereferenceable(32) %ref.tmp43)
          to label %invoke.cont48 unwind label %lpad47

invoke.cont48:                                    ; preds = %invoke.cont46
  store i32 %call49, i32* @B_width, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp43) #2
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp44) #2
  br label %if.end52

lpad35:                                           ; preds = %if.end32
  %26 = landingpad { i8*, i32 }
          cleanup
  %27 = extractvalue { i8*, i32 } %26, 0
  store i8* %27, i8** %exn.slot, align 8
  %28 = extractvalue { i8*, i32 } %26, 1
  store i32 %28, i32* %ehselector.slot, align 4
  br label %ehcleanup41

lpad37:                                           ; preds = %invoke.cont36
  %29 = landingpad { i8*, i32 }
          cleanup
  %30 = extractvalue { i8*, i32 } %29, 0
  store i8* %30, i8** %exn.slot, align 8
  %31 = extractvalue { i8*, i32 } %29, 1
  store i32 %31, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp33) #2
  br label %ehcleanup41

ehcleanup41:                                      ; preds = %lpad37, %lpad35
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp34) #2
  br label %ehcleanup81

lpad45:                                           ; preds = %if.then42
  %32 = landingpad { i8*, i32 }
          cleanup
  %33 = extractvalue { i8*, i32 } %32, 0
  store i8* %33, i8** %exn.slot, align 8
  %34 = extractvalue { i8*, i32 } %32, 1
  store i32 %34, i32* %ehselector.slot, align 4
  br label %ehcleanup51

lpad47:                                           ; preds = %invoke.cont46
  %35 = landingpad { i8*, i32 }
          cleanup
  %36 = extractvalue { i8*, i32 } %35, 0
  store i8* %36, i8** %exn.slot, align 8
  %37 = extractvalue { i8*, i32 } %35, 1
  store i32 %37, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp43) #2
  br label %ehcleanup51

ehcleanup51:                                      ; preds = %lpad47, %lpad45
  call void @_ZNSaIcED1Ev(%"class.std::allocator.9"* %ref.tmp44) #2
  br label %ehcleanup81

if.end52:                                         ; preds = %invoke.cont48, %invoke.cont38
  %38 = load i32, i32* @A_height, align 4
  %39 = load i32, i32* @A_width, align 4
  %40 = load i32, i32* @A_width, align 4
  %41 = load i32, i32* @B_width, align 4
  %42 = load i32, i32* @A_height, align 4
  %43 = load i32, i32* @B_width, align 4
  %call55 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.13, i64 0, i64 0), i32 %38, i32 %39, i32 %40, i32 %41, i32 %42, i32 %43)
          to label %invoke.cont54 unwind label %lpad53

invoke.cont54:                                    ; preds = %if.end52
  %44 = load i32, i32* @A_height, align 4
  %rem = urem i32 %44, 64
  %cmp = icmp ne i32 %rem, 0
  br i1 %cmp, label %if.then70, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %invoke.cont54
  %45 = load i32, i32* @A_width, align 4
  %rem56 = urem i32 %45, 64
  %cmp57 = icmp ne i32 %rem56, 0
  br i1 %cmp57, label %if.then70, label %lor.lhs.false58

lor.lhs.false58:                                  ; preds = %lor.lhs.false
  %46 = load i32, i32* @A_width, align 4
  %rem59 = urem i32 %46, 64
  %cmp60 = icmp ne i32 %rem59, 0
  br i1 %cmp60, label %if.then70, label %lor.lhs.false61

lor.lhs.false61:                                  ; preds = %lor.lhs.false58
  %47 = load i32, i32* @B_width, align 4
  %rem62 = urem i32 %47, 64
  %cmp63 = icmp ne i32 %rem62, 0
  br i1 %cmp63, label %if.then70, label %lor.lhs.false64

lor.lhs.false64:                                  ; preds = %lor.lhs.false61
  %48 = load i32, i32* @A_height, align 4
  %rem65 = urem i32 %48, 64
  %cmp66 = icmp ne i32 %rem65, 0
  br i1 %cmp66, label %if.then70, label %lor.lhs.false67

lor.lhs.false67:                                  ; preds = %lor.lhs.false64
  %49 = load i32, i32* @B_width, align 4
  %rem68 = urem i32 %49, 64
  %cmp69 = icmp ne i32 %rem68, 0
  br i1 %cmp69, label %if.then70, label %if.end73

if.then70:                                        ; preds = %lor.lhs.false67, %lor.lhs.false64, %lor.lhs.false61, %lor.lhs.false58, %lor.lhs.false, %invoke.cont54
  %call72 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.14, i64 0, i64 0), i32 64)
          to label %invoke.cont71 unwind label %lpad53

invoke.cont71:                                    ; preds = %if.then70
  store i32 -1, i32* %retval, align 4
  store i32 1, i32* %cleanup.dest.slot, align 4
  br label %cleanup

lpad53:                                           ; preds = %invoke.cont79, %invoke.cont78, %if.end77, %if.end73, %if.then70, %if.end52
  %50 = landingpad { i8*, i32 }
          cleanup
  %51 = extractvalue { i8*, i32 } %50, 0
  store i8* %51, i8** %exn.slot, align 8
  %52 = extractvalue { i8*, i32 } %50, 1
  store i32 %52, i32* %ehselector.slot, align 4
  br label %ehcleanup81

if.end73:                                         ; preds = %lor.lhs.false67
  %call75 = invoke zeroext i1 @_Z11init_openclv()
          to label %invoke.cont74 unwind label %lpad53

invoke.cont74:                                    ; preds = %if.end73
  br i1 %call75, label %if.end77, label %if.then76

if.then76:                                        ; preds = %invoke.cont74
  store i32 -1, i32* %retval, align 4
  store i32 1, i32* %cleanup.dest.slot, align 4
  br label %cleanup

if.end77:                                         ; preds = %invoke.cont74
  invoke void @_Z12init_problemv()
          to label %invoke.cont78 unwind label %lpad53

invoke.cont78:                                    ; preds = %if.end77
  invoke void @_Z3runv()
          to label %invoke.cont79 unwind label %lpad53

invoke.cont79:                                    ; preds = %invoke.cont78
  invoke void @_Z7cleanupv()
          to label %invoke.cont80 unwind label %lpad53

invoke.cont80:                                    ; preds = %invoke.cont79
  store i32 0, i32* %retval, align 4
  store i32 1, i32* %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %invoke.cont80, %if.then76, %invoke.cont71
  call void @_ZN10aocl_utils7OptionsD2Ev(%"class.aocl_utils::Options"* %options) #2
  %53 = load i32, i32* %retval, align 4
  ret i32 %53

ehcleanup81:                                      ; preds = %lpad53, %ehcleanup51, %ehcleanup41, %ehcleanup31, %ehcleanup21, %ehcleanup12, %ehcleanup
  call void @_ZN10aocl_utils7OptionsD2Ev(%"class.aocl_utils::Options"* %options) #2
  br label %eh.resume

eh.resume:                                        ; preds = %ehcleanup81
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val82 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val82
}

declare dso_local void @_ZN10aocl_utils7OptionsC1EiPPc(%"class.aocl_utils::Options"*, i32, i8**) unnamed_addr #4

declare dso_local zeroext i1 @_ZNK10aocl_utils7Options3hasERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"*, %"class.std::__cxx11::basic_string"* dereferenceable(32)) #4

; Function Attrs: nounwind
declare dso_local void @_ZNSaIcEC1Ev(%"class.std::allocator.9"*) unnamed_addr #5

declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_(%"class.std::__cxx11::basic_string"*, i8*, %"class.std::allocator.9"* dereferenceable(1)) unnamed_addr #4

declare dso_local i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"*) unnamed_addr #5

; Function Attrs: nounwind
declare dso_local void @_ZNSaIcED1Ev(%"class.std::allocator.9"*) unnamed_addr #5

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local i32 @_ZNK10aocl_utils7Options3getIjEET_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %this, %"class.std::__cxx11::basic_string"* dereferenceable(32) %name) #6 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::Options"*, align 8
  %name.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %ss = alloca %"class.std::__cxx11::basic_stringstream", align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %v = alloca i32, align 4
  store %"class.aocl_utils::Options"* %this, %"class.aocl_utils::Options"** %this.addr, align 8
  store %"class.std::__cxx11::basic_string"* %name, %"class.std::__cxx11::basic_string"** %name.addr, align 8
  %this1 = load %"class.aocl_utils::Options"*, %"class.aocl_utils::Options"** %this.addr, align 8
  %call = call i32 @_ZStorSt13_Ios_OpenmodeS_(i32 16, i32 8)
  call void @_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode(%"class.std::__cxx11::basic_stringstream"* %ss, i32 %call)
  %0 = bitcast %"class.std::__cxx11::basic_stringstream"* %ss to i8*
  %add.ptr = getelementptr inbounds i8, i8* %0, i64 16
  %1 = bitcast i8* %add.ptr to %"class.std::basic_ostream"*
  %2 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %name.addr, align 8
  %call2 = invoke dereferenceable(32) %"class.std::__cxx11::basic_string"* @_ZNK10aocl_utils7Options3getERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %this1, %"class.std::__cxx11::basic_string"* dereferenceable(32) %2)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %call4 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* dereferenceable(272) %1, %"class.std::__cxx11::basic_string"* dereferenceable(32) %call2)
          to label %invoke.cont3 unwind label %lpad

invoke.cont3:                                     ; preds = %invoke.cont
  %3 = bitcast %"class.std::__cxx11::basic_stringstream"* %ss to %"class.std::basic_istream"*
  %call6 = invoke dereferenceable(280) %"class.std::basic_istream"* @_ZNSirsERj(%"class.std::basic_istream"* %3, i32* dereferenceable(4) %v)
          to label %invoke.cont5 unwind label %lpad

invoke.cont5:                                     ; preds = %invoke.cont3
  %4 = bitcast %"class.std::__cxx11::basic_stringstream"* %ss to i8**
  %vtable = load i8*, i8** %4, align 8
  %vbase.offset.ptr = getelementptr i8, i8* %vtable, i64 -24
  %5 = bitcast i8* %vbase.offset.ptr to i64*
  %vbase.offset = load i64, i64* %5, align 8
  %6 = bitcast %"class.std::__cxx11::basic_stringstream"* %ss to i8*
  %add.ptr7 = getelementptr inbounds i8, i8* %6, i64 %vbase.offset
  %7 = bitcast i8* %add.ptr7 to %"class.std::basic_ios"*
  %call9 = invoke zeroext i1 @_ZNKSt9basic_iosIcSt11char_traitsIcEE4failEv(%"class.std::basic_ios"* %7)
          to label %invoke.cont8 unwind label %lpad

invoke.cont8:                                     ; preds = %invoke.cont5
  br i1 %call9, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %invoke.cont8
  %8 = bitcast %"class.std::__cxx11::basic_stringstream"* %ss to i8**
  %vtable10 = load i8*, i8** %8, align 8
  %vbase.offset.ptr11 = getelementptr i8, i8* %vtable10, i64 -24
  %9 = bitcast i8* %vbase.offset.ptr11 to i64*
  %vbase.offset12 = load i64, i64* %9, align 8
  %10 = bitcast %"class.std::__cxx11::basic_stringstream"* %ss to i8*
  %add.ptr13 = getelementptr inbounds i8, i8* %10, i64 %vbase.offset12
  %11 = bitcast i8* %add.ptr13 to %"class.std::basic_ios"*
  %call15 = invoke zeroext i1 @_ZNKSt9basic_iosIcSt11char_traitsIcEE3eofEv(%"class.std::basic_ios"* %11)
          to label %invoke.cont14 unwind label %lpad

invoke.cont14:                                    ; preds = %lor.lhs.false
  br i1 %call15, label %if.end, label %if.then

if.then:                                          ; preds = %invoke.cont14, %invoke.cont8
  %12 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %name.addr, align 8
  invoke void @_ZNK10aocl_utils7Options14errorWrongTypeERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"* %this1, %"class.std::__cxx11::basic_string"* dereferenceable(32) %12)
          to label %invoke.cont16 unwind label %lpad

invoke.cont16:                                    ; preds = %if.then
  br label %if.end

lpad:                                             ; preds = %if.then, %lor.lhs.false, %invoke.cont5, %invoke.cont3, %invoke.cont, %entry
  %13 = landingpad { i8*, i32 }
          cleanup
  %14 = extractvalue { i8*, i32 } %13, 0
  store i8* %14, i8** %exn.slot, align 8
  %15 = extractvalue { i8*, i32 } %13, 1
  store i32 %15, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_stringstream"* %ss) #2
  br label %eh.resume

if.end:                                           ; preds = %invoke.cont16, %invoke.cont14
  %16 = load i32, i32* %v, align 4
  call void @_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_stringstream"* %ss) #2
  ret i32 %16

eh.resume:                                        ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val17 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val17
}

declare dso_local i32 @printf(i8*, ...) #4

; Function Attrs: noinline optnone uwtable
define dso_local zeroext i1 @_Z11init_openclv() #6 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %retval = alloca i1, align 1
  %status = alloca i32, align 4
  %ref.tmp = alloca %"class.std::__cxx11::basic_string", align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %i = alloca i32, align 4
  %ref.tmp11 = alloca %"class.std::__cxx11::basic_string", align 8
  %binary_file = alloca %"class.std::__cxx11::basic_string", align 8
  %num_block_rows = alloca i32, align 4
  %i43 = alloca i32, align 4
  %kernel_name = alloca i8*, align 8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.15, i64 0, i64 0))
  %call1 = call zeroext i1 @_ZN10aocl_utils14setCwdToExeDirEv()
  br i1 %call1, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i1 false, i1* %retval, align 1
  br label %return

if.end:                                           ; preds = %entry
  %call2 = call %struct._cl_platform_id* @_ZN10aocl_utils12findPlatformEPKc(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.16, i64 0, i64 0))
  store %struct._cl_platform_id* %call2, %struct._cl_platform_id** @platform, align 8
  %0 = load %struct._cl_platform_id*, %struct._cl_platform_id** @platform, align 8
  %cmp = icmp eq %struct._cl_platform_id* %0, null
  br i1 %cmp, label %if.then3, label %if.end5

if.then3:                                         ; preds = %if.end
  %call4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.17, i64 0, i64 0))
  store i1 false, i1* %retval, align 1
  br label %return

if.end5:                                          ; preds = %if.end
  %1 = load %struct._cl_platform_id*, %struct._cl_platform_id** @platform, align 8
  %call6 = call %struct._cl_device_id** @_ZN10aocl_utils10getDevicesEP15_cl_platform_idmPj(%struct._cl_platform_id* %1, i64 4294967295, i32* @num_devices)
  call void @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idE5resetEPS2_(%"class.aocl_utils::scoped_array"* @device, %struct._cl_device_id** %call6)
  %2 = load %struct._cl_platform_id*, %struct._cl_platform_id** @platform, align 8
  call void @_ZN10aocl_utils15getPlatformNameB5cxx11EP15_cl_platform_id(%"class.std::__cxx11::basic_string"* sret %ref.tmp, %struct._cl_platform_id* %2)
  %call7 = call i8* @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(%"class.std::__cxx11::basic_string"* %ref.tmp) #2
  %call8 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.18, i64 0, i64 0), i8* %call7)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %if.end5
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp) #2
  %3 = load i32, i32* @num_devices, align 4
  %call9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.19, i64 0, i64 0), i32 %3)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %invoke.cont
  %4 = load i32, i32* %i, align 4
  %5 = load i32, i32* @num_devices, align 4
  %cmp10 = icmp ult i32 %4, %5
  br i1 %cmp10, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i32, i32* %i, align 4
  %call12 = call dereferenceable(8) %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEixEi(%"class.aocl_utils::scoped_array"* @device, i32 %6)
  %7 = load %struct._cl_device_id*, %struct._cl_device_id** %call12, align 8
  call void @_ZN10aocl_utils13getDeviceNameB5cxx11EP13_cl_device_id(%"class.std::__cxx11::basic_string"* sret %ref.tmp11, %struct._cl_device_id* %7)
  %call13 = call i8* @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(%"class.std::__cxx11::basic_string"* %ref.tmp11) #2
  %call16 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.20, i64 0, i64 0), i8* %call13)
          to label %invoke.cont15 unwind label %lpad14

invoke.cont15:                                    ; preds = %for.body
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp11) #2
  br label %for.inc

for.inc:                                          ; preds = %invoke.cont15
  %8 = load i32, i32* %i, align 4
  %inc = add i32 %8, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

lpad:                                             ; preds = %if.end5
  %9 = landingpad { i8*, i32 }
          cleanup
  %10 = extractvalue { i8*, i32 } %9, 0
  store i8* %10, i8** %exn.slot, align 8
  %11 = extractvalue { i8*, i32 } %9, 1
  store i32 %11, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp) #2
  br label %eh.resume

lpad14:                                           ; preds = %for.body
  %12 = landingpad { i8*, i32 }
          cleanup
  %13 = extractvalue { i8*, i32 } %12, 0
  store i8* %13, i8** %exn.slot, align 8
  %14 = extractvalue { i8*, i32 } %12, 1
  store i32 %14, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %ref.tmp11) #2
  br label %eh.resume

for.end:                                          ; preds = %for.cond
  %15 = load i32, i32* @num_devices, align 4
  %call17 = call %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEcvPS2_Ev(%"class.aocl_utils::scoped_array"* @device)
  %call18 = call %struct._cl_context* @clCreateContext(i64* null, i32 %15, %struct._cl_device_id** %call17, void (i8*, i8*, i64, i8*)* @_ZN10aocl_utils18oclContextCallbackEPKcPKvmPv, i8* null, i32* %status)
  store %struct._cl_context* %call18, %struct._cl_context** @context, align 8
  %16 = load i32, i32* %status, align 4
  call void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 144, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %16, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.22, i64 0, i64 0))
  %call19 = call dereferenceable(8) %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEixEi(%"class.aocl_utils::scoped_array"* @device, i32 0)
  %17 = load %struct._cl_device_id*, %struct._cl_device_id** %call19, align 8
  call void @_ZN10aocl_utils18getBoardBinaryFileB5cxx11EPKcP13_cl_device_id(%"class.std::__cxx11::basic_string"* sret %binary_file, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.23, i64 0, i64 0), %struct._cl_device_id* %17)
  %call20 = call i8* @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(%"class.std::__cxx11::basic_string"* %binary_file) #2
  %call23 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.24, i64 0, i64 0), i8* %call20)
          to label %invoke.cont22 unwind label %lpad21

invoke.cont22:                                    ; preds = %for.end
  %18 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %call24 = call i8* @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(%"class.std::__cxx11::basic_string"* %binary_file) #2
  %call26 = invoke %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEcvPS2_Ev(%"class.aocl_utils::scoped_array"* @device)
          to label %invoke.cont25 unwind label %lpad21

invoke.cont25:                                    ; preds = %invoke.cont22
  %19 = load i32, i32* @num_devices, align 4
  %call28 = invoke %struct._cl_program* @_ZN10aocl_utils23createProgramFromBinaryEP11_cl_contextPKcPKP13_cl_device_idj(%struct._cl_context* %18, i8* %call24, %struct._cl_device_id** %call26, i32 %19)
          to label %invoke.cont27 unwind label %lpad21

invoke.cont27:                                    ; preds = %invoke.cont25
  store %struct._cl_program* %call28, %struct._cl_program** @program, align 8
  %20 = load %struct._cl_program*, %struct._cl_program** @program, align 8
  %call30 = invoke i32 @clBuildProgram(%struct._cl_program* %20, i32 0, %struct._cl_device_id** null, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.25, i64 0, i64 0), void (%struct._cl_program*, i8*)* null, i8* null)
          to label %invoke.cont29 unwind label %lpad21

invoke.cont29:                                    ; preds = %invoke.cont27
  store i32 %call30, i32* %status, align 4
  %21 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 154, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %21, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.26, i64 0, i64 0))
          to label %invoke.cont31 unwind label %lpad21

invoke.cont31:                                    ; preds = %invoke.cont29
  %22 = load i32, i32* @num_devices, align 4
  %conv = zext i32 %22 to i64
  invoke void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEm(%"class.aocl_utils::scoped_array.0"* @queue, i64 %conv)
          to label %invoke.cont32 unwind label %lpad21

invoke.cont32:                                    ; preds = %invoke.cont31
  %23 = load i32, i32* @num_devices, align 4
  %conv33 = zext i32 %23 to i64
  invoke void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEm(%"class.aocl_utils::scoped_array.1"* @kernel, i64 %conv33)
          to label %invoke.cont34 unwind label %lpad21

invoke.cont34:                                    ; preds = %invoke.cont32
  %24 = load i32, i32* @num_devices, align 4
  %conv35 = zext i32 %24 to i64
  invoke void @_ZN10aocl_utils12scoped_arrayIjE5resetEm(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i64 %conv35)
          to label %invoke.cont36 unwind label %lpad21

invoke.cont36:                                    ; preds = %invoke.cont34
  %25 = load i32, i32* @num_devices, align 4
  %conv37 = zext i32 %25 to i64
  invoke void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEm(%"class.aocl_utils::scoped_array.2"* @input_a_buf, i64 %conv37)
          to label %invoke.cont38 unwind label %lpad21

invoke.cont38:                                    ; preds = %invoke.cont36
  %26 = load i32, i32* @num_devices, align 4
  %conv39 = zext i32 %26 to i64
  invoke void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEm(%"class.aocl_utils::scoped_array.2"* @input_b_buf, i64 %conv39)
          to label %invoke.cont40 unwind label %lpad21

invoke.cont40:                                    ; preds = %invoke.cont38
  %27 = load i32, i32* @num_devices, align 4
  %conv41 = zext i32 %27 to i64
  invoke void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEm(%"class.aocl_utils::scoped_array.2"* @output_buf, i64 %conv41)
          to label %invoke.cont42 unwind label %lpad21

invoke.cont42:                                    ; preds = %invoke.cont40
  %28 = load i32, i32* @A_height, align 4
  %div = udiv i32 %28, 64
  store i32 %div, i32* %num_block_rows, align 4
  store i32 0, i32* %i43, align 4
  br label %for.cond44

for.cond44:                                       ; preds = %for.inc98, %invoke.cont42
  %29 = load i32, i32* %i43, align 4
  %30 = load i32, i32* @num_devices, align 4
  %cmp45 = icmp ult i32 %29, %30
  br i1 %cmp45, label %for.body46, label %for.end100

for.body46:                                       ; preds = %for.cond44
  %31 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %32 = load i32, i32* %i43, align 4
  %call48 = invoke dereferenceable(8) %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEixEi(%"class.aocl_utils::scoped_array"* @device, i32 %32)
          to label %invoke.cont47 unwind label %lpad21

invoke.cont47:                                    ; preds = %for.body46
  %33 = load %struct._cl_device_id*, %struct._cl_device_id** %call48, align 8
  %call50 = invoke %struct._cl_command_queue* @clCreateCommandQueue(%struct._cl_context* %31, %struct._cl_device_id* %33, i64 2, i32* %status)
          to label %invoke.cont49 unwind label %lpad21

invoke.cont49:                                    ; preds = %invoke.cont47
  %34 = load i32, i32* %i43, align 4
  %call52 = invoke dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %34)
          to label %invoke.cont51 unwind label %lpad21

invoke.cont51:                                    ; preds = %invoke.cont49
  store %struct._cl_command_queue* %call50, %struct._cl_command_queue** %call52, align 8
  %35 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 169, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %35, i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.27, i64 0, i64 0))
          to label %invoke.cont53 unwind label %lpad21

invoke.cont53:                                    ; preds = %invoke.cont51
  store i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.28, i64 0, i64 0), i8** %kernel_name, align 8
  %36 = load %struct._cl_program*, %struct._cl_program** @program, align 8
  %37 = load i8*, i8** %kernel_name, align 8
  %call55 = invoke %struct._cl_kernel* @clCreateKernel(%struct._cl_program* %36, i8* %37, i32* %status)
          to label %invoke.cont54 unwind label %lpad21

invoke.cont54:                                    ; preds = %invoke.cont53
  %38 = load i32, i32* %i43, align 4
  %call57 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %38)
          to label %invoke.cont56 unwind label %lpad21

invoke.cont56:                                    ; preds = %invoke.cont54
  store %struct._cl_kernel* %call55, %struct._cl_kernel** %call57, align 8
  %39 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 174, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %39, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.29, i64 0, i64 0))
          to label %invoke.cont58 unwind label %lpad21

invoke.cont58:                                    ; preds = %invoke.cont56
  %40 = load i32, i32* %num_block_rows, align 4
  %41 = load i32, i32* @num_devices, align 4
  %div59 = udiv i32 %40, %41
  %42 = load i32, i32* %i43, align 4
  %call61 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %42)
          to label %invoke.cont60 unwind label %lpad21

invoke.cont60:                                    ; preds = %invoke.cont58
  store i32 %div59, i32* %call61, align 4
  %43 = load i32, i32* %i43, align 4
  %44 = load i32, i32* %num_block_rows, align 4
  %45 = load i32, i32* @num_devices, align 4
  %rem = urem i32 %44, %45
  %cmp62 = icmp ult i32 %43, %rem
  br i1 %cmp62, label %if.then63, label %if.end67

if.then63:                                        ; preds = %invoke.cont60
  %46 = load i32, i32* %i43, align 4
  %call65 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %46)
          to label %invoke.cont64 unwind label %lpad21

invoke.cont64:                                    ; preds = %if.then63
  %47 = load i32, i32* %call65, align 4
  %inc66 = add i32 %47, 1
  store i32 %inc66, i32* %call65, align 4
  br label %if.end67

lpad21:                                           ; preds = %invoke.cont95, %invoke.cont93, %invoke.cont88, %invoke.cont87, %invoke.cont85, %invoke.cont83, %invoke.cont79, %invoke.cont77, %invoke.cont75, %invoke.cont70, %invoke.cont68, %if.end67, %if.then63, %invoke.cont58, %invoke.cont56, %invoke.cont54, %invoke.cont53, %invoke.cont51, %invoke.cont49, %invoke.cont47, %for.body46, %invoke.cont40, %invoke.cont38, %invoke.cont36, %invoke.cont34, %invoke.cont32, %invoke.cont31, %invoke.cont29, %invoke.cont27, %invoke.cont25, %invoke.cont22, %for.end
  %48 = landingpad { i8*, i32 }
          cleanup
  %49 = extractvalue { i8*, i32 } %48, 0
  store i8* %49, i8** %exn.slot, align 8
  %50 = extractvalue { i8*, i32 } %48, 1
  store i32 %50, i32* %ehselector.slot, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %binary_file) #2
  br label %eh.resume

if.end67:                                         ; preds = %invoke.cont64, %invoke.cont60
  %51 = load i32, i32* %i43, align 4
  %call69 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %51)
          to label %invoke.cont68 unwind label %lpad21

invoke.cont68:                                    ; preds = %if.end67
  %52 = load i32, i32* %call69, align 4
  %mul = mul i32 %52, 64
  store i32 %mul, i32* %call69, align 4
  %53 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %54 = load i32, i32* %i43, align 4
  %call71 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %54)
          to label %invoke.cont70 unwind label %lpad21

invoke.cont70:                                    ; preds = %invoke.cont68
  %55 = load i32, i32* %call71, align 4
  %56 = load i32, i32* @A_width, align 4
  %mul72 = mul i32 %55, %56
  %conv73 = zext i32 %mul72 to i64
  %mul74 = mul i64 %conv73, 4
  %call76 = invoke %struct._cl_mem* @clCreateBuffer(%struct._cl_context* %53, i64 4, i64 %mul74, i8* null, i32* %status)
          to label %invoke.cont75 unwind label %lpad21

invoke.cont75:                                    ; preds = %invoke.cont70
  %57 = load i32, i32* %i43, align 4
  %call78 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_a_buf, i32 %57)
          to label %invoke.cont77 unwind label %lpad21

invoke.cont77:                                    ; preds = %invoke.cont75
  store %struct._cl_mem* %call76, %struct._cl_mem** %call78, align 8
  %58 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 197, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %58, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.30, i64 0, i64 0))
          to label %invoke.cont79 unwind label %lpad21

invoke.cont79:                                    ; preds = %invoke.cont77
  %59 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %60 = load i32, i32* @A_width, align 4
  %61 = load i32, i32* @B_width, align 4
  %mul80 = mul i32 %60, %61
  %conv81 = zext i32 %mul80 to i64
  %mul82 = mul i64 %conv81, 4
  %call84 = invoke %struct._cl_mem* @clCreateBuffer(%struct._cl_context* %59, i64 4, i64 %mul82, i8* null, i32* %status)
          to label %invoke.cont83 unwind label %lpad21

invoke.cont83:                                    ; preds = %invoke.cont79
  %62 = load i32, i32* %i43, align 4
  %call86 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_b_buf, i32 %62)
          to label %invoke.cont85 unwind label %lpad21

invoke.cont85:                                    ; preds = %invoke.cont83
  store %struct._cl_mem* %call84, %struct._cl_mem** %call86, align 8
  %63 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 205, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %63, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.31, i64 0, i64 0))
          to label %invoke.cont87 unwind label %lpad21

invoke.cont87:                                    ; preds = %invoke.cont85
  %64 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %65 = load i32, i32* %i43, align 4
  %call89 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %65)
          to label %invoke.cont88 unwind label %lpad21

invoke.cont88:                                    ; preds = %invoke.cont87
  %66 = load i32, i32* %call89, align 4
  %67 = load i32, i32* @B_width, align 4
  %mul90 = mul i32 %66, %67
  %conv91 = zext i32 %mul90 to i64
  %mul92 = mul i64 %conv91, 4
  %call94 = invoke %struct._cl_mem* @clCreateBuffer(%struct._cl_context* %64, i64 2, i64 %mul92, i8* null, i32* %status)
          to label %invoke.cont93 unwind label %lpad21

invoke.cont93:                                    ; preds = %invoke.cont88
  %68 = load i32, i32* %i43, align 4
  %call96 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @output_buf, i32 %68)
          to label %invoke.cont95 unwind label %lpad21

invoke.cont95:                                    ; preds = %invoke.cont93
  store %struct._cl_mem* %call94, %struct._cl_mem** %call96, align 8
  %69 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 216, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %69, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.32, i64 0, i64 0))
          to label %invoke.cont97 unwind label %lpad21

invoke.cont97:                                    ; preds = %invoke.cont95
  br label %for.inc98

for.inc98:                                        ; preds = %invoke.cont97
  %70 = load i32, i32* %i43, align 4
  %inc99 = add i32 %70, 1
  store i32 %inc99, i32* %i43, align 4
  br label %for.cond44

for.end100:                                       ; preds = %for.cond44
  store i1 true, i1* %retval, align 1
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %binary_file) #2
  br label %return

return:                                           ; preds = %for.end100, %if.then3, %if.then
  %71 = load i1, i1* %retval, align 1
  ret i1 %71

eh.resume:                                        ; preds = %lpad21, %lpad14, %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val101 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val101
}

; Function Attrs: noinline optnone uwtable
define dso_local void @_Z12init_problemv() #6 {
entry:
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %i23 = alloca i32, align 4
  %0 = load i32, i32* @num_devices, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 225, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 -1, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.33, i64 0, i64 0))
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.34, i64 0, i64 0))
  %1 = load i32, i32* @num_devices, align 4
  %conv = zext i32 %1 to i64
  call void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEm(%"class.aocl_utils::scoped_array.3"* @input_a, i64 %conv)
  %2 = load i32, i32* @num_devices, align 4
  %conv1 = zext i32 %2 to i64
  call void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEm(%"class.aocl_utils::scoped_array.3"* @output, i64 %conv1)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %if.end
  %3 = load i32, i32* %i, align 4
  %4 = load i32, i32* @num_devices, align 4
  %cmp2 = icmp ult i32 %3, %4
  br i1 %cmp2, label %for.body, label %for.end20

for.body:                                         ; preds = %for.cond
  %5 = load i32, i32* %i, align 4
  %call3 = call dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @input_a, i32 %5)
  %6 = load i32, i32* %i, align 4
  %call4 = call dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %6)
  %7 = load i32, i32* %call4, align 4
  %8 = load i32, i32* @A_width, align 4
  %mul = mul i32 %7, %8
  %conv5 = zext i32 %mul to i64
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEm(%"class.aocl_utils::scoped_aligned_ptr"* %call3, i64 %conv5)
  %9 = load i32, i32* %i, align 4
  %call6 = call dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @output, i32 %9)
  %10 = load i32, i32* %i, align 4
  %call7 = call dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %10)
  %11 = load i32, i32* %call7, align 4
  %12 = load i32, i32* @B_width, align 4
  %mul8 = mul i32 %11, %12
  %conv9 = zext i32 %mul8 to i64
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEm(%"class.aocl_utils::scoped_aligned_ptr"* %call6, i64 %conv9)
  store i32 0, i32* %j, align 4
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc, %for.body
  %13 = load i32, i32* %j, align 4
  %14 = load i32, i32* %i, align 4
  %call11 = call dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %14)
  %15 = load i32, i32* %call11, align 4
  %16 = load i32, i32* @A_width, align 4
  %mul12 = mul i32 %15, %16
  %cmp13 = icmp ult i32 %13, %mul12
  br i1 %cmp13, label %for.body14, label %for.end

for.body14:                                       ; preds = %for.cond10
  %call15 = call float @_Z10rand_floatv()
  %17 = load i32, i32* %i, align 4
  %call16 = call dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @input_a, i32 %17)
  %18 = load i32, i32* %j, align 4
  %call17 = call dereferenceable(4) float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi(%"class.aocl_utils::scoped_aligned_ptr"* %call16, i32 %18)
  store float %call15, float* %call17, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body14
  %19 = load i32, i32* %j, align 4
  %inc = add i32 %19, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond10

for.end:                                          ; preds = %for.cond10
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %20 = load i32, i32* %i, align 4
  %inc19 = add i32 %20, 1
  store i32 %inc19, i32* %i, align 4
  br label %for.cond

for.end20:                                        ; preds = %for.cond
  %21 = load i32, i32* @A_width, align 4
  %22 = load i32, i32* @B_width, align 4
  %mul21 = mul i32 %21, %22
  %conv22 = zext i32 %mul21 to i64
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEm(%"class.aocl_utils::scoped_aligned_ptr"* @input_b, i64 %conv22)
  store i32 0, i32* %i23, align 4
  br label %for.cond24

for.cond24:                                       ; preds = %for.inc30, %for.end20
  %23 = load i32, i32* %i23, align 4
  %24 = load i32, i32* @A_width, align 4
  %25 = load i32, i32* @B_width, align 4
  %mul25 = mul i32 %24, %25
  %cmp26 = icmp ult i32 %23, %mul25
  br i1 %cmp26, label %for.body27, label %for.end32

for.body27:                                       ; preds = %for.cond24
  %call28 = call float @_Z10rand_floatv()
  %26 = load i32, i32* %i23, align 4
  %call29 = call dereferenceable(4) float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi(%"class.aocl_utils::scoped_aligned_ptr"* @input_b, i32 %26)
  store float %call28, float* %call29, align 4
  br label %for.inc30

for.inc30:                                        ; preds = %for.body27
  %27 = load i32, i32* %i23, align 4
  %inc31 = add i32 %27, 1
  store i32 %inc31, i32* %i23, align 4
  br label %for.cond24

for.end32:                                        ; preds = %for.cond24
  ret void
}

; Function Attrs: noinline optnone uwtable
define dso_local void @_Z3runv() #6 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %status = alloca i32, align 4
  %i = alloca i32, align 4
  %i14 = alloca i32, align 4
  %kernel_event = alloca %"class.aocl_utils::scoped_array.12", align 8
  %start_time = alloca double, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %i25 = alloca i32, align 4
  %argi = alloca i32, align 4
  %global_work_size = alloca [2 x i64], align 16
  %local_work_size = alloca [2 x i64], align 16
  %stop_time = alloca double, align 8
  %kernel_time = alloca double, align 8
  %i99 = alloca i32, align 4
  %time_ns = alloca i64, align 8
  %flops = alloca float, align 4
  %i126 = alloca i32, align 4
  %i137 = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* @num_devices, align 4
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %call = call dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %2)
  %3 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call, align 8
  %4 = load i32, i32* %i, align 4
  %call1 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_a_buf, i32 %4)
  %5 = load %struct._cl_mem*, %struct._cl_mem** %call1, align 8
  %6 = load i32, i32* %i, align 4
  %call2 = call dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %6)
  %7 = load i32, i32* %call2, align 4
  %8 = load i32, i32* @A_width, align 4
  %mul = mul i32 %7, %8
  %conv = zext i32 %mul to i64
  %mul3 = mul i64 %conv, 4
  %9 = load i32, i32* %i, align 4
  %call4 = call dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @input_a, i32 %9)
  %call5 = call float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEcvPfEv(%"class.aocl_utils::scoped_aligned_ptr"* %call4)
  %10 = bitcast float* %call5 to i8*
  %call6 = call i32 @clEnqueueWriteBuffer(%struct._cl_command_queue* %3, %struct._cl_mem* %5, i32 0, i64 0, i64 %mul3, i8* %10, i32 0, %struct._cl_event** null, %struct._cl_event** null)
  store i32 %call6, i32* %status, align 4
  %11 = load i32, i32* %status, align 4
  call void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 258, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %11, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.35, i64 0, i64 0))
  %12 = load i32, i32* %i, align 4
  %call7 = call dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %12)
  %13 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call7, align 8
  %14 = load i32, i32* %i, align 4
  %call8 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_b_buf, i32 %14)
  %15 = load %struct._cl_mem*, %struct._cl_mem** %call8, align 8
  %16 = load i32, i32* @B_width, align 4
  %17 = load i32, i32* @A_width, align 4
  %mul9 = mul i32 %16, %17
  %conv10 = zext i32 %mul9 to i64
  %mul11 = mul i64 %conv10, 4
  %call12 = call float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEcvPfEv(%"class.aocl_utils::scoped_aligned_ptr"* @input_b)
  %18 = bitcast float* %call12 to i8*
  %call13 = call i32 @clEnqueueWriteBuffer(%struct._cl_command_queue* %13, %struct._cl_mem* %15, i32 0, i64 0, i64 %mul11, i8* %18, i32 0, %struct._cl_event** null, %struct._cl_event** null)
  store i32 %call13, i32* %status, align 4
  %19 = load i32, i32* %status, align 4
  call void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 262, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %19, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.36, i64 0, i64 0))
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %20 = load i32, i32* %i, align 4
  %inc = add i32 %20, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i14, align 4
  br label %for.cond15

for.cond15:                                       ; preds = %for.inc20, %for.end
  %21 = load i32, i32* %i14, align 4
  %22 = load i32, i32* @num_devices, align 4
  %cmp16 = icmp ult i32 %21, %22
  br i1 %cmp16, label %for.body17, label %for.end22

for.body17:                                       ; preds = %for.cond15
  %23 = load i32, i32* %i14, align 4
  %call18 = call dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %23)
  %24 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call18, align 8
  %call19 = call i32 @clFinish(%struct._cl_command_queue* %24)
  br label %for.inc20

for.inc20:                                        ; preds = %for.body17
  %25 = load i32, i32* %i14, align 4
  %inc21 = add i32 %25, 1
  store i32 %inc21, i32* %i14, align 4
  br label %for.cond15

for.end22:                                        ; preds = %for.cond15
  %26 = load i32, i32* @num_devices, align 4
  %conv23 = zext i32 %26 to i64
  call void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventEC2Em(%"class.aocl_utils::scoped_array.12"* %kernel_event, i64 %conv23)
  %call24 = invoke double @_ZN10aocl_utils19getCurrentTimestampEv()
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %for.end22
  store double %call24, double* %start_time, align 8
  store i32 0, i32* %i25, align 4
  br label %for.cond26

for.cond26:                                       ; preds = %for.inc86, %invoke.cont
  %27 = load i32, i32* %i25, align 4
  %28 = load i32, i32* @num_devices, align 4
  %cmp27 = icmp ult i32 %27, %28
  br i1 %cmp27, label %for.body28, label %for.end88

for.body28:                                       ; preds = %for.cond26
  store i32 0, i32* %argi, align 4
  %29 = load i32, i32* %i25, align 4
  %call30 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %29)
          to label %invoke.cont29 unwind label %lpad

invoke.cont29:                                    ; preds = %for.body28
  %30 = load %struct._cl_kernel*, %struct._cl_kernel** %call30, align 8
  %31 = load i32, i32* %argi, align 4
  %inc31 = add i32 %31, 1
  store i32 %inc31, i32* %argi, align 4
  %32 = load i32, i32* %i25, align 4
  %call33 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @output_buf, i32 %32)
          to label %invoke.cont32 unwind label %lpad

invoke.cont32:                                    ; preds = %invoke.cont29
  %33 = bitcast %struct._cl_mem** %call33 to i8*
  %call35 = invoke i32 @clSetKernelArg(%struct._cl_kernel* %30, i32 %31, i64 8, i8* %33)
          to label %invoke.cont34 unwind label %lpad

invoke.cont34:                                    ; preds = %invoke.cont32
  store i32 %call35, i32* %status, align 4
  %34 = load i32, i32* %status, align 4
  %35 = load i32, i32* %argi, align 4
  %sub = sub i32 %35, 1
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 282, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %34, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.37, i64 0, i64 0), i32 %sub)
          to label %invoke.cont36 unwind label %lpad

invoke.cont36:                                    ; preds = %invoke.cont34
  %36 = load i32, i32* %i25, align 4
  %call38 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %36)
          to label %invoke.cont37 unwind label %lpad

invoke.cont37:                                    ; preds = %invoke.cont36
  %37 = load %struct._cl_kernel*, %struct._cl_kernel** %call38, align 8
  %38 = load i32, i32* %argi, align 4
  %inc39 = add i32 %38, 1
  store i32 %inc39, i32* %argi, align 4
  %39 = load i32, i32* %i25, align 4
  %call41 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_a_buf, i32 %39)
          to label %invoke.cont40 unwind label %lpad

invoke.cont40:                                    ; preds = %invoke.cont37
  %40 = bitcast %struct._cl_mem** %call41 to i8*
  %call43 = invoke i32 @clSetKernelArg(%struct._cl_kernel* %37, i32 %38, i64 8, i8* %40)
          to label %invoke.cont42 unwind label %lpad

invoke.cont42:                                    ; preds = %invoke.cont40
  store i32 %call43, i32* %status, align 4
  %41 = load i32, i32* %status, align 4
  %42 = load i32, i32* %argi, align 4
  %sub44 = sub i32 %42, 1
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 285, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %41, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.37, i64 0, i64 0), i32 %sub44)
          to label %invoke.cont45 unwind label %lpad

invoke.cont45:                                    ; preds = %invoke.cont42
  %43 = load i32, i32* %i25, align 4
  %call47 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %43)
          to label %invoke.cont46 unwind label %lpad

invoke.cont46:                                    ; preds = %invoke.cont45
  %44 = load %struct._cl_kernel*, %struct._cl_kernel** %call47, align 8
  %45 = load i32, i32* %argi, align 4
  %inc48 = add i32 %45, 1
  store i32 %inc48, i32* %argi, align 4
  %46 = load i32, i32* %i25, align 4
  %call50 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_b_buf, i32 %46)
          to label %invoke.cont49 unwind label %lpad

invoke.cont49:                                    ; preds = %invoke.cont46
  %47 = bitcast %struct._cl_mem** %call50 to i8*
  %call52 = invoke i32 @clSetKernelArg(%struct._cl_kernel* %44, i32 %45, i64 8, i8* %47)
          to label %invoke.cont51 unwind label %lpad

invoke.cont51:                                    ; preds = %invoke.cont49
  store i32 %call52, i32* %status, align 4
  %48 = load i32, i32* %status, align 4
  %49 = load i32, i32* %argi, align 4
  %sub53 = sub i32 %49, 1
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 288, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %48, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.37, i64 0, i64 0), i32 %sub53)
          to label %invoke.cont54 unwind label %lpad

invoke.cont54:                                    ; preds = %invoke.cont51
  %50 = load i32, i32* %i25, align 4
  %call56 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %50)
          to label %invoke.cont55 unwind label %lpad

invoke.cont55:                                    ; preds = %invoke.cont54
  %51 = load %struct._cl_kernel*, %struct._cl_kernel** %call56, align 8
  %52 = load i32, i32* %argi, align 4
  %inc57 = add i32 %52, 1
  store i32 %inc57, i32* %argi, align 4
  %call59 = invoke i32 @clSetKernelArg(%struct._cl_kernel* %51, i32 %52, i64 4, i8* bitcast (i32* @A_width to i8*))
          to label %invoke.cont58 unwind label %lpad

invoke.cont58:                                    ; preds = %invoke.cont55
  store i32 %call59, i32* %status, align 4
  %53 = load i32, i32* %status, align 4
  %54 = load i32, i32* %argi, align 4
  %sub60 = sub i32 %54, 1
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 291, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %53, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.37, i64 0, i64 0), i32 %sub60)
          to label %invoke.cont61 unwind label %lpad

invoke.cont61:                                    ; preds = %invoke.cont58
  %55 = load i32, i32* %i25, align 4
  %call63 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %55)
          to label %invoke.cont62 unwind label %lpad

invoke.cont62:                                    ; preds = %invoke.cont61
  %56 = load %struct._cl_kernel*, %struct._cl_kernel** %call63, align 8
  %57 = load i32, i32* %argi, align 4
  %inc64 = add i32 %57, 1
  store i32 %inc64, i32* %argi, align 4
  %call66 = invoke i32 @clSetKernelArg(%struct._cl_kernel* %56, i32 %57, i64 4, i8* bitcast (i32* @B_width to i8*))
          to label %invoke.cont65 unwind label %lpad

invoke.cont65:                                    ; preds = %invoke.cont62
  store i32 %call66, i32* %status, align 4
  %58 = load i32, i32* %status, align 4
  %59 = load i32, i32* %argi, align 4
  %sub67 = sub i32 %59, 1
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 294, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %58, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.37, i64 0, i64 0), i32 %sub67)
          to label %invoke.cont68 unwind label %lpad

invoke.cont68:                                    ; preds = %invoke.cont65
  %arrayinit.begin = getelementptr inbounds [2 x i64], [2 x i64]* %global_work_size, i64 0, i64 0
  %60 = load i32, i32* @B_width, align 4
  %conv69 = zext i32 %60 to i64
  store i64 %conv69, i64* %arrayinit.begin, align 8
  %arrayinit.element = getelementptr inbounds i64, i64* %arrayinit.begin, i64 1
  %61 = load i32, i32* %i25, align 4
  %call71 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %61)
          to label %invoke.cont70 unwind label %lpad

invoke.cont70:                                    ; preds = %invoke.cont68
  %62 = load i32, i32* %call71, align 4
  %conv72 = zext i32 %62 to i64
  store i64 %conv72, i64* %arrayinit.element, align 8
  %63 = bitcast [2 x i64]* %local_work_size to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %63, i8* align 16 bitcast ([2 x i64]* @__const._Z3runv.local_work_size to i8*), i64 16, i1 false)
  %64 = load i32, i32* %i25, align 4
  %arrayidx = getelementptr inbounds [2 x i64], [2 x i64]* %global_work_size, i64 0, i64 0
  %65 = load i64, i64* %arrayidx, align 16
  %arrayidx73 = getelementptr inbounds [2 x i64], [2 x i64]* %global_work_size, i64 0, i64 1
  %66 = load i64, i64* %arrayidx73, align 8
  %call75 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([47 x i8], [47 x i8]* @.str.38, i64 0, i64 0), i32 %64, i64 %65, i64 %66)
          to label %invoke.cont74 unwind label %lpad

invoke.cont74:                                    ; preds = %invoke.cont70
  %67 = load i32, i32* %i25, align 4
  %call77 = invoke dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %67)
          to label %invoke.cont76 unwind label %lpad

invoke.cont76:                                    ; preds = %invoke.cont74
  %68 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call77, align 8
  %69 = load i32, i32* %i25, align 4
  %call79 = invoke dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %69)
          to label %invoke.cont78 unwind label %lpad

invoke.cont78:                                    ; preds = %invoke.cont76
  %70 = load %struct._cl_kernel*, %struct._cl_kernel** %call79, align 8
  %arraydecay = getelementptr inbounds [2 x i64], [2 x i64]* %global_work_size, i64 0, i64 0
  %arraydecay80 = getelementptr inbounds [2 x i64], [2 x i64]* %local_work_size, i64 0, i64 0
  %71 = load i32, i32* %i25, align 4
  %call82 = invoke dereferenceable(8) %struct._cl_event** @_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEixEi(%"class.aocl_utils::scoped_array.12"* %kernel_event, i32 %71)
          to label %invoke.cont81 unwind label %lpad

invoke.cont81:                                    ; preds = %invoke.cont78
  %call84 = invoke i32 @clEnqueueNDRangeKernel(%struct._cl_command_queue* %68, %struct._cl_kernel* %70, i32 2, i64* null, i64* %arraydecay, i64* %arraydecay80, i32 0, %struct._cl_event** null, %struct._cl_event** %call82)
          to label %invoke.cont83 unwind label %lpad

invoke.cont83:                                    ; preds = %invoke.cont81
  store i32 %call84, i32* %status, align 4
  %72 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 311, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %72, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.39, i64 0, i64 0))
          to label %invoke.cont85 unwind label %lpad

invoke.cont85:                                    ; preds = %invoke.cont83
  br label %for.inc86

for.inc86:                                        ; preds = %invoke.cont85
  %73 = load i32, i32* %i25, align 4
  %inc87 = add i32 %73, 1
  store i32 %inc87, i32* %i25, align 4
  br label %for.cond26

lpad:                                             ; preds = %invoke.cont160, %for.end159, %invoke.cont154, %invoke.cont152, %invoke.cont150, %invoke.cont145, %invoke.cont143, %invoke.cont141, %for.body140, %invoke.cont130, %for.body129, %for.end113, %invoke.cont105, %invoke.cont103, %for.body102, %invoke.cont93, %invoke.cont91, %invoke.cont89, %for.end88, %invoke.cont83, %invoke.cont81, %invoke.cont78, %invoke.cont76, %invoke.cont74, %invoke.cont70, %invoke.cont68, %invoke.cont65, %invoke.cont62, %invoke.cont61, %invoke.cont58, %invoke.cont55, %invoke.cont54, %invoke.cont51, %invoke.cont49, %invoke.cont46, %invoke.cont45, %invoke.cont42, %invoke.cont40, %invoke.cont37, %invoke.cont36, %invoke.cont34, %invoke.cont32, %invoke.cont29, %for.body28, %for.end22
  %74 = landingpad { i8*, i32 }
          cleanup
  %75 = extractvalue { i8*, i32 } %74, 0
  store i8* %75, i8** %exn.slot, align 8
  %76 = extractvalue { i8*, i32 } %74, 1
  store i32 %76, i32* %ehselector.slot, align 4
  call void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventED2Ev(%"class.aocl_utils::scoped_array.12"* %kernel_event) #2
  br label %eh.resume

for.end88:                                        ; preds = %for.cond26
  %77 = load i32, i32* @num_devices, align 4
  %call90 = invoke %struct._cl_event** @_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEcvPS2_Ev(%"class.aocl_utils::scoped_array.12"* %kernel_event)
          to label %invoke.cont89 unwind label %lpad

invoke.cont89:                                    ; preds = %for.end88
  %call92 = invoke i32 @clWaitForEvents(i32 %77, %struct._cl_event** %call90)
          to label %invoke.cont91 unwind label %lpad

invoke.cont91:                                    ; preds = %invoke.cont89
  %call94 = invoke double @_ZN10aocl_utils19getCurrentTimestampEv()
          to label %invoke.cont93 unwind label %lpad

invoke.cont93:                                    ; preds = %invoke.cont91
  store double %call94, double* %stop_time, align 8
  %78 = load double, double* %stop_time, align 8
  %79 = load double, double* %start_time, align 8
  %sub95 = fsub double %78, %79
  store double %sub95, double* %kernel_time, align 8
  %80 = load double, double* %kernel_time, align 8
  %mul96 = fmul double %80, 1.000000e+03
  %call98 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.40, i64 0, i64 0), double %mul96)
          to label %invoke.cont97 unwind label %lpad

invoke.cont97:                                    ; preds = %invoke.cont93
  store i32 0, i32* %i99, align 4
  br label %for.cond100

for.cond100:                                      ; preds = %for.inc111, %invoke.cont97
  %81 = load i32, i32* %i99, align 4
  %82 = load i32, i32* @num_devices, align 4
  %cmp101 = icmp ult i32 %81, %82
  br i1 %cmp101, label %for.body102, label %for.end113

for.body102:                                      ; preds = %for.cond100
  %83 = load i32, i32* %i99, align 4
  %call104 = invoke dereferenceable(8) %struct._cl_event** @_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEixEi(%"class.aocl_utils::scoped_array.12"* %kernel_event, i32 %83)
          to label %invoke.cont103 unwind label %lpad

invoke.cont103:                                   ; preds = %for.body102
  %84 = load %struct._cl_event*, %struct._cl_event** %call104, align 8
  %call106 = invoke i64 @_ZN10aocl_utils15getStartEndTimeEP9_cl_event(%struct._cl_event* %84)
          to label %invoke.cont105 unwind label %lpad

invoke.cont105:                                   ; preds = %invoke.cont103
  store i64 %call106, i64* %time_ns, align 8
  %85 = load i64, i64* %time_ns, align 8
  %conv107 = uitofp i64 %85 to double
  %mul108 = fmul double %conv107, 0x3EB0C6F7A0B5ED8D
  %call110 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.41, i64 0, i64 0), double %mul108)
          to label %invoke.cont109 unwind label %lpad

invoke.cont109:                                   ; preds = %invoke.cont105
  br label %for.inc111

for.inc111:                                       ; preds = %invoke.cont109
  %86 = load i32, i32* %i99, align 4
  %inc112 = add i32 %86, 1
  store i32 %inc112, i32* %i99, align 4
  br label %for.cond100

for.end113:                                       ; preds = %for.cond100
  %87 = load i32, i32* @B_width, align 4
  %conv114 = uitofp i32 %87 to float
  %mul115 = fmul float 2.000000e+00, %conv114
  %88 = load i32, i32* @A_height, align 4
  %conv116 = uitofp i32 %88 to float
  %mul117 = fmul float %mul115, %conv116
  %89 = load i32, i32* @A_width, align 4
  %conv118 = uitofp i32 %89 to float
  %mul119 = fmul float %mul117, %conv118
  %conv120 = fpext float %mul119 to double
  %90 = load double, double* %kernel_time, align 8
  %div = fdiv double %conv120, %90
  %conv121 = fptrunc double %div to float
  store float %conv121, float* %flops, align 4
  %91 = load float, float* %flops, align 4
  %conv122 = fpext float %91 to double
  %mul123 = fmul double %conv122, 1.000000e-09
  %call125 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.42, i64 0, i64 0), double %mul123)
          to label %invoke.cont124 unwind label %lpad

invoke.cont124:                                   ; preds = %for.end113
  store i32 0, i32* %i126, align 4
  br label %for.cond127

for.cond127:                                      ; preds = %for.inc134, %invoke.cont124
  %92 = load i32, i32* %i126, align 4
  %93 = load i32, i32* @num_devices, align 4
  %cmp128 = icmp ult i32 %92, %93
  br i1 %cmp128, label %for.body129, label %for.end136

for.body129:                                      ; preds = %for.cond127
  %94 = load i32, i32* %i126, align 4
  %call131 = invoke dereferenceable(8) %struct._cl_event** @_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEixEi(%"class.aocl_utils::scoped_array.12"* %kernel_event, i32 %94)
          to label %invoke.cont130 unwind label %lpad

invoke.cont130:                                   ; preds = %for.body129
  %95 = load %struct._cl_event*, %struct._cl_event** %call131, align 8
  %call133 = invoke i32 @clReleaseEvent(%struct._cl_event* %95)
          to label %invoke.cont132 unwind label %lpad

invoke.cont132:                                   ; preds = %invoke.cont130
  br label %for.inc134

for.inc134:                                       ; preds = %invoke.cont132
  %96 = load i32, i32* %i126, align 4
  %inc135 = add i32 %96, 1
  store i32 %inc135, i32* %i126, align 4
  br label %for.cond127

for.end136:                                       ; preds = %for.cond127
  store i32 0, i32* %i137, align 4
  br label %for.cond138

for.cond138:                                      ; preds = %for.inc157, %for.end136
  %97 = load i32, i32* %i137, align 4
  %98 = load i32, i32* @num_devices, align 4
  %cmp139 = icmp ult i32 %97, %98
  br i1 %cmp139, label %for.body140, label %for.end159

for.body140:                                      ; preds = %for.cond138
  %99 = load i32, i32* %i137, align 4
  %call142 = invoke dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %99)
          to label %invoke.cont141 unwind label %lpad

invoke.cont141:                                   ; preds = %for.body140
  %100 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call142, align 8
  %101 = load i32, i32* %i137, align 4
  %call144 = invoke dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @output_buf, i32 %101)
          to label %invoke.cont143 unwind label %lpad

invoke.cont143:                                   ; preds = %invoke.cont141
  %102 = load %struct._cl_mem*, %struct._cl_mem** %call144, align 8
  %103 = load i32, i32* %i137, align 4
  %call146 = invoke dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %103)
          to label %invoke.cont145 unwind label %lpad

invoke.cont145:                                   ; preds = %invoke.cont143
  %104 = load i32, i32* %call146, align 4
  %105 = load i32, i32* @B_width, align 4
  %mul147 = mul i32 %104, %105
  %conv148 = zext i32 %mul147 to i64
  %mul149 = mul i64 %conv148, 4
  %106 = load i32, i32* %i137, align 4
  %call151 = invoke dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @output, i32 %106)
          to label %invoke.cont150 unwind label %lpad

invoke.cont150:                                   ; preds = %invoke.cont145
  %call153 = invoke float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEcvPfEv(%"class.aocl_utils::scoped_aligned_ptr"* %call151)
          to label %invoke.cont152 unwind label %lpad

invoke.cont152:                                   ; preds = %invoke.cont150
  %107 = bitcast float* %call153 to i8*
  %call155 = invoke i32 @clEnqueueReadBuffer(%struct._cl_command_queue* %100, %struct._cl_mem* %102, i32 1, i64 0, i64 %mul149, i8* %107, i32 0, %struct._cl_event** null, %struct._cl_event** null)
          to label %invoke.cont154 unwind label %lpad

invoke.cont154:                                   ; preds = %invoke.cont152
  store i32 %call155, i32* %status, align 4
  %108 = load i32, i32* %status, align 4
  invoke void (i32, i8*, i32, i8*, ...) @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32 346, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.21, i64 0, i64 0), i32 %108, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.43, i64 0, i64 0))
          to label %invoke.cont156 unwind label %lpad

invoke.cont156:                                   ; preds = %invoke.cont154
  br label %for.inc157

for.inc157:                                       ; preds = %invoke.cont156
  %109 = load i32, i32* %i137, align 4
  %inc158 = add i32 %109, 1
  store i32 %inc158, i32* %i137, align 4
  br label %for.cond138

for.end159:                                       ; preds = %for.cond138
  invoke void @_Z17compute_referencev()
          to label %invoke.cont160 unwind label %lpad

invoke.cont160:                                   ; preds = %for.end159
  invoke void @_Z6verifyv()
          to label %invoke.cont161 unwind label %lpad

invoke.cont161:                                   ; preds = %invoke.cont160
  call void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventED2Ev(%"class.aocl_utils::scoped_array.12"* %kernel_event) #2
  ret void

eh.resume:                                        ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val162 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val162
}

; Function Attrs: noinline optnone uwtable
define dso_local void @_Z7cleanupv() #6 {
entry:
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* @num_devices, align 4
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call = call %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEcvPS2_Ev(%"class.aocl_utils::scoped_array.1"* @kernel)
  %tobool = icmp ne %struct._cl_kernel** %call, null
  br i1 %tobool, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body
  %2 = load i32, i32* %i, align 4
  %call1 = call dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %2)
  %3 = load %struct._cl_kernel*, %struct._cl_kernel** %call1, align 8
  %tobool2 = icmp ne %struct._cl_kernel* %3, null
  br i1 %tobool2, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %4 = load i32, i32* %i, align 4
  %call3 = call dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* @kernel, i32 %4)
  %5 = load %struct._cl_kernel*, %struct._cl_kernel** %call3, align 8
  %call4 = call i32 @clReleaseKernel(%struct._cl_kernel* %5)
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body
  %call5 = call %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEcvPS2_Ev(%"class.aocl_utils::scoped_array.0"* @queue)
  %tobool6 = icmp ne %struct._cl_command_queue** %call5, null
  br i1 %tobool6, label %land.lhs.true7, label %if.end13

land.lhs.true7:                                   ; preds = %if.end
  %6 = load i32, i32* %i, align 4
  %call8 = call dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %6)
  %7 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call8, align 8
  %tobool9 = icmp ne %struct._cl_command_queue* %7, null
  br i1 %tobool9, label %if.then10, label %if.end13

if.then10:                                        ; preds = %land.lhs.true7
  %8 = load i32, i32* %i, align 4
  %call11 = call dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* @queue, i32 %8)
  %9 = load %struct._cl_command_queue*, %struct._cl_command_queue** %call11, align 8
  %call12 = call i32 @clReleaseCommandQueue(%struct._cl_command_queue* %9)
  br label %if.end13

if.end13:                                         ; preds = %if.then10, %land.lhs.true7, %if.end
  %call14 = call %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEcvPS2_Ev(%"class.aocl_utils::scoped_array.2"* @input_a_buf)
  %tobool15 = icmp ne %struct._cl_mem** %call14, null
  br i1 %tobool15, label %land.lhs.true16, label %if.end22

land.lhs.true16:                                  ; preds = %if.end13
  %10 = load i32, i32* %i, align 4
  %call17 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_a_buf, i32 %10)
  %11 = load %struct._cl_mem*, %struct._cl_mem** %call17, align 8
  %tobool18 = icmp ne %struct._cl_mem* %11, null
  br i1 %tobool18, label %if.then19, label %if.end22

if.then19:                                        ; preds = %land.lhs.true16
  %12 = load i32, i32* %i, align 4
  %call20 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_a_buf, i32 %12)
  %13 = load %struct._cl_mem*, %struct._cl_mem** %call20, align 8
  %call21 = call i32 @clReleaseMemObject(%struct._cl_mem* %13)
  br label %if.end22

if.end22:                                         ; preds = %if.then19, %land.lhs.true16, %if.end13
  %call23 = call %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEcvPS2_Ev(%"class.aocl_utils::scoped_array.2"* @input_b_buf)
  %tobool24 = icmp ne %struct._cl_mem** %call23, null
  br i1 %tobool24, label %land.lhs.true25, label %if.end31

land.lhs.true25:                                  ; preds = %if.end22
  %14 = load i32, i32* %i, align 4
  %call26 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_b_buf, i32 %14)
  %15 = load %struct._cl_mem*, %struct._cl_mem** %call26, align 8
  %tobool27 = icmp ne %struct._cl_mem* %15, null
  br i1 %tobool27, label %if.then28, label %if.end31

if.then28:                                        ; preds = %land.lhs.true25
  %16 = load i32, i32* %i, align 4
  %call29 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @input_b_buf, i32 %16)
  %17 = load %struct._cl_mem*, %struct._cl_mem** %call29, align 8
  %call30 = call i32 @clReleaseMemObject(%struct._cl_mem* %17)
  br label %if.end31

if.end31:                                         ; preds = %if.then28, %land.lhs.true25, %if.end22
  %call32 = call %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEcvPS2_Ev(%"class.aocl_utils::scoped_array.2"* @output_buf)
  %tobool33 = icmp ne %struct._cl_mem** %call32, null
  br i1 %tobool33, label %land.lhs.true34, label %if.end40

land.lhs.true34:                                  ; preds = %if.end31
  %18 = load i32, i32* %i, align 4
  %call35 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @output_buf, i32 %18)
  %19 = load %struct._cl_mem*, %struct._cl_mem** %call35, align 8
  %tobool36 = icmp ne %struct._cl_mem* %19, null
  br i1 %tobool36, label %if.then37, label %if.end40

if.then37:                                        ; preds = %land.lhs.true34
  %20 = load i32, i32* %i, align 4
  %call38 = call dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* @output_buf, i32 %20)
  %21 = load %struct._cl_mem*, %struct._cl_mem** %call38, align 8
  %call39 = call i32 @clReleaseMemObject(%struct._cl_mem* %21)
  br label %if.end40

if.end40:                                         ; preds = %if.then37, %land.lhs.true34, %if.end31
  br label %for.inc

for.inc:                                          ; preds = %if.end40
  %22 = load i32, i32* %i, align 4
  %inc = add i32 %22, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %23 = load %struct._cl_program*, %struct._cl_program** @program, align 8
  %tobool41 = icmp ne %struct._cl_program* %23, null
  br i1 %tobool41, label %if.then42, label %if.end44

if.then42:                                        ; preds = %for.end
  %24 = load %struct._cl_program*, %struct._cl_program** @program, align 8
  %call43 = call i32 @clReleaseProgram(%struct._cl_program* %24)
  br label %if.end44

if.end44:                                         ; preds = %if.then42, %for.end
  %25 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %tobool45 = icmp ne %struct._cl_context* %25, null
  br i1 %tobool45, label %if.then46, label %if.end48

if.then46:                                        ; preds = %if.end44
  %26 = load %struct._cl_context*, %struct._cl_context** @context, align 8
  %call47 = call i32 @clReleaseContext(%struct._cl_context* %26)
  br label %if.end48

if.end48:                                         ; preds = %if.then46, %if.end44
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils7OptionsD2Ev(%"class.aocl_utils::Options"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::Options"*, align 8
  store %"class.aocl_utils::Options"* %this, %"class.aocl_utils::Options"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::Options"*, %"class.aocl_utils::Options"** %this.addr, align 8
  %m_nonoptions = getelementptr inbounds %"class.aocl_utils::Options", %"class.aocl_utils::Options"* %this1, i32 0, i32 1
  call void @_ZNSt6vectorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev(%"class.std::vector"* %m_nonoptions) #2
  %m_options = getelementptr inbounds %"class.aocl_utils::Options", %"class.aocl_utils::Options"* %this1, i32 0, i32 0
  call void @_ZNSt3mapINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_St4lessIS5_ESaISt4pairIKS5_S5_EEED2Ev(%"class.std::map"* %m_options) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local float @_Z10rand_floatv() #1 {
entry:
  %call = call i32 @rand() #2
  %conv = sitofp i32 %call to float
  %div = fdiv float %conv, 0x41E0000000000000
  %mul = fmul float %div, 2.000000e+01
  %sub = fsub float %mul, 1.000000e+01
  ret float %sub
}

; Function Attrs: nounwind
declare dso_local i32 @rand() #5

declare dso_local zeroext i1 @_ZN10aocl_utils14setCwdToExeDirEv() #4

declare dso_local %struct._cl_platform_id* @_ZN10aocl_utils12findPlatformEPKc(i8*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP13_cl_device_idE5resetEPS2_(%"class.aocl_utils::scoped_array"* %this, %struct._cl_device_id** %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array"*, align 8
  %ptr.addr = alloca %struct._cl_device_id**, align 8
  store %"class.aocl_utils::scoped_array"* %this, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  store %struct._cl_device_id** %ptr, %struct._cl_device_id*** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array"*, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array", %"class.aocl_utils::scoped_array"* %this1, i32 0, i32 0
  %0 = load %struct._cl_device_id**, %struct._cl_device_id*** %m_ptr, align 8
  %isnull = icmp eq %struct._cl_device_id** %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast %struct._cl_device_id** %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load %struct._cl_device_id**, %struct._cl_device_id*** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array", %"class.aocl_utils::scoped_array"* %this1, i32 0, i32 0
  store %struct._cl_device_id** %2, %struct._cl_device_id*** %m_ptr2, align 8
  ret void
}

declare dso_local %struct._cl_device_id** @_ZN10aocl_utils10getDevicesEP15_cl_platform_idmPj(%struct._cl_platform_id*, i64, i32*) #4

declare dso_local void @_ZN10aocl_utils15getPlatformNameB5cxx11EP15_cl_platform_id(%"class.std::__cxx11::basic_string"* sret, %struct._cl_platform_id*) #4

; Function Attrs: nounwind
declare dso_local i8* @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(%"class.std::__cxx11::basic_string"*) #5

declare dso_local void @_ZN10aocl_utils13getDeviceNameB5cxx11EP13_cl_device_id(%"class.std::__cxx11::basic_string"* sret, %struct._cl_device_id*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(8) %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEixEi(%"class.aocl_utils::scoped_array"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array"* %this, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array"*, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array", %"class.aocl_utils::scoped_array"* %this1, i32 0, i32 0
  %0 = load %struct._cl_device_id**, %struct._cl_device_id*** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds %struct._cl_device_id*, %struct._cl_device_id** %0, i64 %idxprom
  ret %struct._cl_device_id** %arrayidx
}

declare dso_local %struct._cl_context* @clCreateContext(i64*, i32, %struct._cl_device_id**, void (i8*, i8*, i64, i8*)*, i8*, i32*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %struct._cl_device_id** @_ZNK10aocl_utils12scoped_arrayIP13_cl_device_idEcvPS2_Ev(%"class.aocl_utils::scoped_array"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array"*, align 8
  store %"class.aocl_utils::scoped_array"* %this, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array"*, %"class.aocl_utils::scoped_array"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array", %"class.aocl_utils::scoped_array"* %this1, i32 0, i32 0
  %0 = load %struct._cl_device_id**, %struct._cl_device_id*** %m_ptr, align 8
  ret %struct._cl_device_id** %0
}

declare dso_local void @_ZN10aocl_utils18oclContextCallbackEPKcPKvmPv(i8*, i8*, i64, i8*) #4

declare dso_local void @_ZN10aocl_utils11_checkErrorEiPKciS1_z(i32, i8*, i32, i8*, ...) #4

declare dso_local void @_ZN10aocl_utils18getBoardBinaryFileB5cxx11EPKcP13_cl_device_id(%"class.std::__cxx11::basic_string"* sret, i8*, %struct._cl_device_id*) #4

declare dso_local %struct._cl_program* @_ZN10aocl_utils23createProgramFromBinaryEP11_cl_contextPKcPKP13_cl_device_idj(%struct._cl_context*, i8*, %struct._cl_device_id**, i32) #4

declare dso_local i32 @clBuildProgram(%struct._cl_program*, i32, %struct._cl_device_id**, i8*, void (%struct._cl_program*, i8*)*, i8*) #4

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEm(%"class.aocl_utils::scoped_array.0"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.0"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.0"* %this, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.0"*, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 8)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = select i1 %2, i64 -1, i64 %3
  %call = call i8* @_Znam(i64 %4) #14
  %5 = bitcast i8* %call to %struct._cl_command_queue**
  call void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEPS2_(%"class.aocl_utils::scoped_array.0"* %this1, %struct._cl_command_queue** %5)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEm(%"class.aocl_utils::scoped_array.1"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.1"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.1"* %this, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.1"*, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 8)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = select i1 %2, i64 -1, i64 %3
  %call = call i8* @_Znam(i64 %4) #14
  %5 = bitcast i8* %call to %struct._cl_kernel**
  call void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEPS2_(%"class.aocl_utils::scoped_array.1"* %this1, %struct._cl_kernel** %5)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIjE5resetEm(%"class.aocl_utils::scoped_array.5"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.5"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.5"* %this, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.5"*, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 4)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = select i1 %2, i64 -1, i64 %3
  %call = call i8* @_Znam(i64 %4) #14
  %5 = bitcast i8* %call to i32*
  call void @_ZN10aocl_utils12scoped_arrayIjE5resetEPj(%"class.aocl_utils::scoped_array.5"* %this1, i32* %5)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEm(%"class.aocl_utils::scoped_array.2"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.2"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.2"* %this, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.2"*, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 8)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = select i1 %2, i64 -1, i64 %3
  %call = call i8* @_Znam(i64 %4) #14
  %5 = bitcast i8* %call to %struct._cl_mem**
  call void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEPS2_(%"class.aocl_utils::scoped_array.2"* %this1, %struct._cl_mem** %5)
  ret void
}

declare dso_local %struct._cl_command_queue* @clCreateCommandQueue(%struct._cl_context*, %struct._cl_device_id*, i64, i32*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(8) %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEixEi(%"class.aocl_utils::scoped_array.0"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.0"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.0"* %this, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.0"*, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.0", %"class.aocl_utils::scoped_array.0"* %this1, i32 0, i32 0
  %0 = load %struct._cl_command_queue**, %struct._cl_command_queue*** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds %struct._cl_command_queue*, %struct._cl_command_queue** %0, i64 %idxprom
  ret %struct._cl_command_queue** %arrayidx
}

declare dso_local %struct._cl_kernel* @clCreateKernel(%struct._cl_program*, i8*, i32*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(8) %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEixEi(%"class.aocl_utils::scoped_array.1"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.1"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.1"* %this, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.1"*, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.1", %"class.aocl_utils::scoped_array.1"* %this1, i32 0, i32 0
  %0 = load %struct._cl_kernel**, %struct._cl_kernel*** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds %struct._cl_kernel*, %struct._cl_kernel** %0, i64 %idxprom
  ret %struct._cl_kernel** %arrayidx
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.5"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.5"* %this, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.5"*, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.5", %"class.aocl_utils::scoped_array.5"* %this1, i32 0, i32 0
  %0 = load i32*, i32** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom
  ret i32* %arrayidx
}

declare dso_local %struct._cl_mem* @clCreateBuffer(%struct._cl_context*, i64, i64, i8*, i32*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(8) %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEixEi(%"class.aocl_utils::scoped_array.2"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.2"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.2"* %this, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.2"*, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.2", %"class.aocl_utils::scoped_array.2"* %this1, i32 0, i32 0
  %0 = load %struct._cl_mem**, %struct._cl_mem*** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds %struct._cl_mem*, %struct._cl_mem** %0, i64 %idxprom
  ret %struct._cl_mem** %arrayidx
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEm(%"class.aocl_utils::scoped_array.3"* %this, i64 %n) #6 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.3"*, align 8
  %n.addr = alloca i64, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %"class.aocl_utils::scoped_array.3"* %this, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.3"*, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 8)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %3, i64 8)
  %5 = extractvalue { i64, i1 } %4, 1
  %6 = or i1 %2, %5
  %7 = extractvalue { i64, i1 } %4, 0
  %8 = select i1 %6, i64 -1, i64 %7
  %call = call i8* @_Znam(i64 %8) #14
  %9 = bitcast i8* %call to i64*
  store i64 %0, i64* %9, align 8
  %10 = getelementptr inbounds i8, i8* %call, i64 8
  %11 = bitcast i8* %10 to %"class.aocl_utils::scoped_aligned_ptr"*
  %isempty = icmp eq i64 %0, 0
  br i1 %isempty, label %arrayctor.cont, label %new.ctorloop

new.ctorloop:                                     ; preds = %entry
  %arrayctor.end = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %11, i64 %0
  br label %arrayctor.loop

arrayctor.loop:                                   ; preds = %invoke.cont, %new.ctorloop
  %arrayctor.cur = phi %"class.aocl_utils::scoped_aligned_ptr"* [ %11, %new.ctorloop ], [ %arrayctor.next, %invoke.cont ]
  invoke void @_ZN10aocl_utils18scoped_aligned_ptrIfEC2Ev(%"class.aocl_utils::scoped_aligned_ptr"* %arrayctor.cur)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %arrayctor.loop
  %arrayctor.next = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %arrayctor.cur, i64 1
  %arrayctor.done = icmp eq %"class.aocl_utils::scoped_aligned_ptr"* %arrayctor.next, %arrayctor.end
  br i1 %arrayctor.done, label %arrayctor.cont, label %arrayctor.loop

arrayctor.cont:                                   ; preds = %entry, %invoke.cont
  call void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEPS2_(%"class.aocl_utils::scoped_array.3"* %this1, %"class.aocl_utils::scoped_aligned_ptr"* %11)
  ret void

lpad:                                             ; preds = %arrayctor.loop
  %12 = landingpad { i8*, i32 }
          cleanup
  %13 = extractvalue { i8*, i32 } %12, 0
  store i8* %13, i8** %exn.slot, align 8
  %14 = extractvalue { i8*, i32 } %12, 1
  store i32 %14, i32* %ehselector.slot, align 4
  %arraydestroy.isempty = icmp eq %"class.aocl_utils::scoped_aligned_ptr"* %11, %arrayctor.cur
  br i1 %arraydestroy.isempty, label %arraydestroy.done2, label %arraydestroy.body

arraydestroy.body:                                ; preds = %arraydestroy.body, %lpad
  %arraydestroy.elementPast = phi %"class.aocl_utils::scoped_aligned_ptr"* [ %arrayctor.cur, %lpad ], [ %arraydestroy.element, %arraydestroy.body ]
  %arraydestroy.element = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %arraydestroy.elementPast, i64 -1
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfED2Ev(%"class.aocl_utils::scoped_aligned_ptr"* %arraydestroy.element) #2
  %arraydestroy.done = icmp eq %"class.aocl_utils::scoped_aligned_ptr"* %arraydestroy.element, %11
  br i1 %arraydestroy.done, label %arraydestroy.done2, label %arraydestroy.body

arraydestroy.done2:                               ; preds = %arraydestroy.body, %lpad
  call void @_ZdaPv(i8* %call) #13
  br label %eh.resume

eh.resume:                                        ; preds = %arraydestroy.done2
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val3 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.3"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.3"* %this, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.3"*, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.3", %"class.aocl_utils::scoped_array.3"* %this1, i32 0, i32 0
  %0 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %0, i64 %idxprom
  ret %"class.aocl_utils::scoped_aligned_ptr"* %arrayidx
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEm(%"class.aocl_utils::scoped_aligned_ptr"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_aligned_ptr"* %this, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %mul = mul i64 4, %0
  %call = call i8* @_ZN10aocl_utils13alignedMallocEm(i64 %mul)
  %1 = bitcast i8* %call to float*
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEPf(%"class.aocl_utils::scoped_aligned_ptr"* %this1, float* %1)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(4) float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi(%"class.aocl_utils::scoped_aligned_ptr"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_aligned_ptr"* %this, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %this1, i32 0, i32 0
  %0 = load float*, float** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds float, float* %0, i64 %idxprom
  ret float* %arrayidx
}

declare dso_local i32 @clEnqueueWriteBuffer(%struct._cl_command_queue*, %struct._cl_mem*, i32, i64, i64, i8*, i32, %struct._cl_event**, %struct._cl_event**) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEcvPfEv(%"class.aocl_utils::scoped_aligned_ptr"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  store %"class.aocl_utils::scoped_aligned_ptr"* %this, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %this1, i32 0, i32 0
  %0 = load float*, float** %m_ptr, align 8
  ret float* %0
}

declare dso_local i32 @clFinish(%struct._cl_command_queue*) #4

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventEC2Em(%"class.aocl_utils::scoped_array.12"* %this, i64 %n) unnamed_addr #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.12"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.12"* %this, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.12"*, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.12", %"class.aocl_utils::scoped_array.12"* %this1, i32 0, i32 0
  store %struct._cl_event** null, %struct._cl_event*** %m_ptr, align 8
  %0 = load i64, i64* %n.addr, align 8
  call void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEm(%"class.aocl_utils::scoped_array.12"* %this1, i64 %0)
  ret void
}

declare dso_local double @_ZN10aocl_utils19getCurrentTimestampEv() #4

declare dso_local i32 @clSetKernelArg(%struct._cl_kernel*, i32, i64, i8*) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #7

declare dso_local i32 @clEnqueueNDRangeKernel(%struct._cl_command_queue*, %struct._cl_kernel*, i32, i64*, i64*, i64*, i32, %struct._cl_event**, %struct._cl_event**) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(8) %struct._cl_event** @_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEixEi(%"class.aocl_utils::scoped_array.12"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.12"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.12"* %this, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.12"*, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.12", %"class.aocl_utils::scoped_array.12"* %this1, i32 0, i32 0
  %0 = load %struct._cl_event**, %struct._cl_event*** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds %struct._cl_event*, %struct._cl_event** %0, i64 %idxprom
  ret %struct._cl_event** %arrayidx
}

declare dso_local i32 @clWaitForEvents(i32, %struct._cl_event**) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %struct._cl_event** @_ZNK10aocl_utils12scoped_arrayIP9_cl_eventEcvPS2_Ev(%"class.aocl_utils::scoped_array.12"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.12"*, align 8
  store %"class.aocl_utils::scoped_array.12"* %this, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.12"*, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.12", %"class.aocl_utils::scoped_array.12"* %this1, i32 0, i32 0
  %0 = load %struct._cl_event**, %struct._cl_event*** %m_ptr, align 8
  ret %struct._cl_event** %0
}

declare dso_local i64 @_ZN10aocl_utils15getStartEndTimeEP9_cl_event(%struct._cl_event*) #4

declare dso_local i32 @clReleaseEvent(%struct._cl_event*) #4

declare dso_local i32 @clEnqueueReadBuffer(%struct._cl_command_queue*, %struct._cl_mem*, i32, i64, i64, i8*, i32, %struct._cl_event**, %struct._cl_event**) #4

; Function Attrs: noinline optnone uwtable
define dso_local void @_Z17compute_referencev() #6 {
entry:
  %y = alloca i32, align 4
  %dev_index = alloca i32, align 4
  %yy = alloca i32, align 4
  %x = alloca i32, align 4
  %sum = alloca float, align 4
  %k = alloca i32, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.44, i64 0, i64 0))
  %0 = load i32, i32* @A_height, align 4
  %1 = load i32, i32* @B_width, align 4
  %mul = mul i32 %0, %1
  %conv = zext i32 %mul to i64
  call void @_ZN10aocl_utils12scoped_arrayIfE5resetEm(%"class.aocl_utils::scoped_array.4"* @ref_output, i64 %conv)
  store i32 0, i32* %y, align 4
  store i32 0, i32* %dev_index, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc29, %entry
  %2 = load i32, i32* %y, align 4
  %3 = load i32, i32* @A_height, align 4
  %cmp = icmp ult i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end31

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %yy, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc25, %for.body
  %4 = load i32, i32* %yy, align 4
  %5 = load i32, i32* %dev_index, align 4
  %call2 = call dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %5)
  %6 = load i32, i32* %call2, align 4
  %cmp3 = icmp ult i32 %4, %6
  br i1 %cmp3, label %for.body4, label %for.end28

for.body4:                                        ; preds = %for.cond1
  store i32 0, i32* %x, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc22, %for.body4
  %7 = load i32, i32* %x, align 4
  %8 = load i32, i32* @B_width, align 4
  %cmp6 = icmp ult i32 %7, %8
  br i1 %cmp6, label %for.body7, label %for.end24

for.body7:                                        ; preds = %for.cond5
  store float 0.000000e+00, float* %sum, align 4
  store i32 0, i32* %k, align 4
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc, %for.body7
  %9 = load i32, i32* %k, align 4
  %10 = load i32, i32* @A_width, align 4
  %cmp9 = icmp ult i32 %9, %10
  br i1 %cmp9, label %for.body10, label %for.end

for.body10:                                       ; preds = %for.cond8
  %11 = load i32, i32* %dev_index, align 4
  %call11 = call dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @input_a, i32 %11)
  %12 = load i32, i32* %yy, align 4
  %13 = load i32, i32* @A_width, align 4
  %mul12 = mul i32 %12, %13
  %14 = load i32, i32* %k, align 4
  %add = add i32 %mul12, %14
  %call13 = call dereferenceable(4) float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi(%"class.aocl_utils::scoped_aligned_ptr"* %call11, i32 %add)
  %15 = load float, float* %call13, align 4
  %16 = load i32, i32* %k, align 4
  %17 = load i32, i32* @B_width, align 4
  %mul14 = mul i32 %16, %17
  %18 = load i32, i32* %x, align 4
  %add15 = add i32 %mul14, %18
  %call16 = call dereferenceable(4) float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi(%"class.aocl_utils::scoped_aligned_ptr"* @input_b, i32 %add15)
  %19 = load float, float* %call16, align 4
  %mul17 = fmul float %15, %19
  %20 = load float, float* %sum, align 4
  %add18 = fadd float %20, %mul17
  store float %add18, float* %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body10
  %21 = load i32, i32* %k, align 4
  %inc = add i32 %21, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond8

for.end:                                          ; preds = %for.cond8
  %22 = load float, float* %sum, align 4
  %23 = load i32, i32* %y, align 4
  %24 = load i32, i32* @B_width, align 4
  %mul19 = mul i32 %23, %24
  %25 = load i32, i32* %x, align 4
  %add20 = add i32 %mul19, %25
  %call21 = call dereferenceable(4) float* @_ZNK10aocl_utils12scoped_arrayIfEixEi(%"class.aocl_utils::scoped_array.4"* @ref_output, i32 %add20)
  store float %22, float* %call21, align 4
  br label %for.inc22

for.inc22:                                        ; preds = %for.end
  %26 = load i32, i32* %x, align 4
  %inc23 = add i32 %26, 1
  store i32 %inc23, i32* %x, align 4
  br label %for.cond5

for.end24:                                        ; preds = %for.cond5
  br label %for.inc25

for.inc25:                                        ; preds = %for.end24
  %27 = load i32, i32* %yy, align 4
  %inc26 = add i32 %27, 1
  store i32 %inc26, i32* %yy, align 4
  %28 = load i32, i32* %y, align 4
  %inc27 = add i32 %28, 1
  store i32 %inc27, i32* %y, align 4
  br label %for.cond1

for.end28:                                        ; preds = %for.cond1
  br label %for.inc29

for.inc29:                                        ; preds = %for.end28
  %29 = load i32, i32* %dev_index, align 4
  %inc30 = add i32 %29, 1
  store i32 %inc30, i32* %dev_index, align 4
  br label %for.cond

for.end31:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: noinline optnone uwtable
define dso_local void @_Z6verifyv() #6 {
entry:
  %diff = alloca float, align 4
  %ref = alloca float, align 4
  %y = alloca i32, align 4
  %dev_index = alloca i32, align 4
  %yy = alloca i32, align 4
  %x = alloca i32, align 4
  %o = alloca float, align 4
  %r = alloca float, align 4
  %d = alloca float, align 4
  %diff_l2norm = alloca float, align 4
  %ref_l2norm = alloca float, align 4
  %error = alloca float, align 4
  %pass = alloca i8, align 1
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.45, i64 0, i64 0))
  store float 0.000000e+00, float* %diff, align 4
  store float 0.000000e+00, float* %ref, align 4
  store i32 0, i32* %y, align 4
  store i32 0, i32* %dev_index, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc21, %entry
  %0 = load i32, i32* %y, align 4
  %1 = load i32, i32* @A_height, align 4
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end23

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %yy, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc17, %for.body
  %2 = load i32, i32* %yy, align 4
  %3 = load i32, i32* %dev_index, align 4
  %call2 = call dereferenceable(4) i32* @_ZNK10aocl_utils12scoped_arrayIjEixEi(%"class.aocl_utils::scoped_array.5"* @rows_per_device, i32 %3)
  %4 = load i32, i32* %call2, align 4
  %cmp3 = icmp ult i32 %2, %4
  br i1 %cmp3, label %for.body4, label %for.end20

for.body4:                                        ; preds = %for.cond1
  store i32 0, i32* %x, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body4
  %5 = load i32, i32* %x, align 4
  %6 = load i32, i32* @B_width, align 4
  %cmp6 = icmp ult i32 %5, %6
  br i1 %cmp6, label %for.body7, label %for.end

for.body7:                                        ; preds = %for.cond5
  %7 = load i32, i32* %dev_index, align 4
  %call8 = call dereferenceable(8) %"class.aocl_utils::scoped_aligned_ptr"* @_ZNK10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEEixEi(%"class.aocl_utils::scoped_array.3"* @output, i32 %7)
  %8 = load i32, i32* %yy, align 4
  %9 = load i32, i32* @B_width, align 4
  %mul = mul i32 %8, %9
  %10 = load i32, i32* %x, align 4
  %add = add i32 %mul, %10
  %call9 = call dereferenceable(4) float* @_ZNK10aocl_utils18scoped_aligned_ptrIfEixEi(%"class.aocl_utils::scoped_aligned_ptr"* %call8, i32 %add)
  %11 = load float, float* %call9, align 4
  store float %11, float* %o, align 4
  %12 = load i32, i32* %y, align 4
  %13 = load i32, i32* @B_width, align 4
  %mul10 = mul i32 %12, %13
  %14 = load i32, i32* %x, align 4
  %add11 = add i32 %mul10, %14
  %call12 = call dereferenceable(4) float* @_ZNK10aocl_utils12scoped_arrayIfEixEi(%"class.aocl_utils::scoped_array.4"* @ref_output, i32 %add11)
  %15 = load float, float* %call12, align 4
  store float %15, float* %r, align 4
  %16 = load float, float* %o, align 4
  %17 = load float, float* %r, align 4
  %sub = fsub float %16, %17
  store float %sub, float* %d, align 4
  %18 = load float, float* %d, align 4
  %19 = load float, float* %d, align 4
  %mul13 = fmul float %18, %19
  %20 = load float, float* %diff, align 4
  %add14 = fadd float %20, %mul13
  store float %add14, float* %diff, align 4
  %21 = load float, float* %r, align 4
  %22 = load float, float* %r, align 4
  %mul15 = fmul float %21, %22
  %23 = load float, float* %ref, align 4
  %add16 = fadd float %23, %mul15
  store float %add16, float* %ref, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body7
  %24 = load i32, i32* %x, align 4
  %inc = add i32 %24, 1
  store i32 %inc, i32* %x, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc17

for.inc17:                                        ; preds = %for.end
  %25 = load i32, i32* %yy, align 4
  %inc18 = add i32 %25, 1
  store i32 %inc18, i32* %yy, align 4
  %26 = load i32, i32* %y, align 4
  %inc19 = add i32 %26, 1
  store i32 %inc19, i32* %y, align 4
  br label %for.cond1

for.end20:                                        ; preds = %for.cond1
  br label %for.inc21

for.inc21:                                        ; preds = %for.end20
  %27 = load i32, i32* %dev_index, align 4
  %inc22 = add i32 %27, 1
  store i32 %inc22, i32* %dev_index, align 4
  br label %for.cond

for.end23:                                        ; preds = %for.cond
  %28 = load float, float* %diff, align 4
  %call24 = call float @sqrtf(float %28) #2
  store float %call24, float* %diff_l2norm, align 4
  %29 = load float, float* %ref, align 4
  %call25 = call float @sqrtf(float %29) #2
  store float %call25, float* %ref_l2norm, align 4
  %30 = load float, float* %diff_l2norm, align 4
  %31 = load float, float* %ref_l2norm, align 4
  %div = fdiv float %30, %31
  store float %div, float* %error, align 4
  %32 = load float, float* %error, align 4
  %conv = fpext float %32 to double
  %cmp26 = fcmp olt double %conv, 0x3EB0C6F7A0B5ED8D
  %frombool = zext i1 %cmp26 to i8
  store i8 %frombool, i8* %pass, align 1
  %33 = load i8, i8* %pass, align 1
  %tobool = trunc i8 %33 to i1
  br i1 %tobool, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end23
  br label %cond.end

cond.false:                                       ; preds = %for.end23
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond-lvalue = phi [5 x i8]* [ @.str.47, %cond.true ], [ @.str.48, %cond.false ]
  %arraydecay = getelementptr inbounds [5 x i8], [5 x i8]* %cond-lvalue, i64 0, i64 0
  %call27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.46, i64 0, i64 0), i8* %arraydecay)
  %34 = load i8, i8* %pass, align 1
  %tobool28 = trunc i8 %34 to i1
  br i1 %tobool28, label %if.end, label %if.then

if.then:                                          ; preds = %cond.end
  %35 = load float, float* %error, align 4
  %conv29 = fpext float %35 to double
  %call30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.49, i64 0, i64 0), double %conv29)
  br label %if.end

if.end:                                           ; preds = %if.then, %cond.end
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventED2Ev(%"class.aocl_utils::scoped_array.12"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.12"*, align 8
  store %"class.aocl_utils::scoped_array.12"* %this, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.12"*, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  invoke void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEPS2_(%"class.aocl_utils::scoped_array.12"* %this1, %struct._cl_event** null)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  call void @__clang_call_terminate(i8* %1) #12
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIfE5resetEm(%"class.aocl_utils::scoped_array.4"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.4"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.4"* %this, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.4"*, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 4)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = select i1 %2, i64 -1, i64 %3
  %call = call i8* @_Znam(i64 %4) #14
  %5 = bitcast i8* %call to float*
  call void @_ZN10aocl_utils12scoped_arrayIfE5resetEPf(%"class.aocl_utils::scoped_array.4"* %this1, float* %5)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(4) float* @_ZNK10aocl_utils12scoped_arrayIfEixEi(%"class.aocl_utils::scoped_array.4"* %this, i32 %index) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.4"*, align 8
  %index.addr = alloca i32, align 4
  store %"class.aocl_utils::scoped_array.4"* %this, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  store i32 %index, i32* %index.addr, align 4
  %this1 = load %"class.aocl_utils::scoped_array.4"*, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.4", %"class.aocl_utils::scoped_array.4"* %this1, i32 0, i32 0
  %0 = load float*, float** %m_ptr, align 8
  %1 = load i32, i32* %index.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds float, float* %0, i64 %idxprom
  ret float* %arrayidx
}

; Function Attrs: nounwind
declare dso_local float @sqrtf(float) #5

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %struct._cl_kernel** @_ZNK10aocl_utils12scoped_arrayIP10_cl_kernelEcvPS2_Ev(%"class.aocl_utils::scoped_array.1"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.1"*, align 8
  store %"class.aocl_utils::scoped_array.1"* %this, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.1"*, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.1", %"class.aocl_utils::scoped_array.1"* %this1, i32 0, i32 0
  %0 = load %struct._cl_kernel**, %struct._cl_kernel*** %m_ptr, align 8
  ret %struct._cl_kernel** %0
}

declare dso_local i32 @clReleaseKernel(%struct._cl_kernel*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %struct._cl_command_queue** @_ZNK10aocl_utils12scoped_arrayIP17_cl_command_queueEcvPS2_Ev(%"class.aocl_utils::scoped_array.0"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.0"*, align 8
  store %"class.aocl_utils::scoped_array.0"* %this, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.0"*, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.0", %"class.aocl_utils::scoped_array.0"* %this1, i32 0, i32 0
  %0 = load %struct._cl_command_queue**, %struct._cl_command_queue*** %m_ptr, align 8
  ret %struct._cl_command_queue** %0
}

declare dso_local i32 @clReleaseCommandQueue(%struct._cl_command_queue*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %struct._cl_mem** @_ZNK10aocl_utils12scoped_arrayIP7_cl_memEcvPS2_Ev(%"class.aocl_utils::scoped_array.2"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.2"*, align 8
  store %"class.aocl_utils::scoped_array.2"* %this, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.2"*, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.2", %"class.aocl_utils::scoped_array.2"* %this1, i32 0, i32 0
  %0 = load %struct._cl_mem**, %struct._cl_mem*** %m_ptr, align 8
  ret %struct._cl_mem** %0
}

declare dso_local i32 @clReleaseMemObject(%struct._cl_mem*) #4

declare dso_local i32 @clReleaseProgram(%struct._cl_program*) #4

declare dso_local i32 @clReleaseContext(%struct._cl_context*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt6vectorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev(%"class.std::vector"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.std::vector"*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %"class.std::vector"* %this, %"class.std::vector"** %this.addr, align 8
  %this1 = load %"class.std::vector"*, %"class.std::vector"** %this.addr, align 8
  %0 = bitcast %"class.std::vector"* %this1 to %"struct.std::_Vector_base"*
  %_M_impl = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %0, i32 0, i32 0
  %_M_start = getelementptr inbounds %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl", %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl, i32 0, i32 0
  %1 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %_M_start, align 8
  %2 = bitcast %"class.std::vector"* %this1 to %"struct.std::_Vector_base"*
  %_M_impl2 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %2, i32 0, i32 0
  %_M_finish = getelementptr inbounds %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl", %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl2, i32 0, i32 1
  %3 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %_M_finish, align 8
  %4 = bitcast %"class.std::vector"* %this1 to %"struct.std::_Vector_base"*
  %call = call dereferenceable(1) %"class.std::allocator.6"* @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* %4) #2
  invoke void @_ZSt8_DestroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_EvT_S7_RSaIT0_E(%"class.std::__cxx11::basic_string"* %1, %"class.std::__cxx11::basic_string"* %3, %"class.std::allocator.6"* dereferenceable(1) %call)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %5 = bitcast %"class.std::vector"* %this1 to %"struct.std::_Vector_base"*
  call void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev(%"struct.std::_Vector_base"* %5) #2
  ret void

lpad:                                             ; preds = %entry
  %6 = landingpad { i8*, i32 }
          catch i8* null
  %7 = extractvalue { i8*, i32 } %6, 0
  store i8* %7, i8** %exn.slot, align 8
  %8 = extractvalue { i8*, i32 } %6, 1
  store i32 %8, i32* %ehselector.slot, align 4
  %9 = bitcast %"class.std::vector"* %this1 to %"struct.std::_Vector_base"*
  call void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev(%"struct.std::_Vector_base"* %9) #2
  br label %terminate.handler

terminate.handler:                                ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  call void @__clang_call_terminate(i8* %exn) #12
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt3mapINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_St4lessIS5_ESaISt4pairIKS5_S5_EEED2Ev(%"class.std::map"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::map"*, align 8
  store %"class.std::map"* %this, %"class.std::map"** %this.addr, align 8
  %this1 = load %"class.std::map"*, %"class.std::map"** %this.addr, align 8
  %_M_t = getelementptr inbounds %"class.std::map", %"class.std::map"* %this1, i32 0, i32 0
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EED2Ev(%"class.std::_Rb_tree"* %_M_t) #2
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZSt8_DestroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_EvT_S7_RSaIT0_E(%"class.std::__cxx11::basic_string"* %__first, %"class.std::__cxx11::basic_string"* %__last, %"class.std::allocator.6"* dereferenceable(1)) #6 comdat {
entry:
  %__first.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %__last.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %.addr = alloca %"class.std::allocator.6"*, align 8
  store %"class.std::__cxx11::basic_string"* %__first, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  store %"class.std::__cxx11::basic_string"* %__last, %"class.std::__cxx11::basic_string"** %__last.addr, align 8
  store %"class.std::allocator.6"* %0, %"class.std::allocator.6"** %.addr, align 8
  %1 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  %2 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__last.addr, align 8
  call void @_ZSt8_DestroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEvT_S7_(%"class.std::__cxx11::basic_string"* %1, %"class.std::__cxx11::basic_string"* %2)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(1) %"class.std::allocator.6"* @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.std::_Vector_base"*, align 8
  store %"struct.std::_Vector_base"* %this, %"struct.std::_Vector_base"** %this.addr, align 8
  %this1 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %this.addr, align 8
  %_M_impl = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  %0 = bitcast %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl to %"class.std::allocator.6"*
  ret %"class.std::allocator.6"* %0
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EED2Ev(%"struct.std::_Vector_base"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"struct.std::_Vector_base"*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %"struct.std::_Vector_base"* %this, %"struct.std::_Vector_base"** %this.addr, align 8
  %this1 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %this.addr, align 8
  %_M_impl = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  %_M_start = getelementptr inbounds %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl", %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl, i32 0, i32 0
  %0 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %_M_start, align 8
  %_M_impl2 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  %_M_end_of_storage = getelementptr inbounds %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl", %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl2, i32 0, i32 2
  %1 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %_M_end_of_storage, align 8
  %_M_impl3 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  %_M_start4 = getelementptr inbounds %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl", %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl3, i32 0, i32 0
  %2 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %_M_start4, align 8
  %sub.ptr.lhs.cast = ptrtoint %"class.std::__cxx11::basic_string"* %1 to i64
  %sub.ptr.rhs.cast = ptrtoint %"class.std::__cxx11::basic_string"* %2 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %sub.ptr.div = sdiv exact i64 %sub.ptr.sub, 32
  invoke void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE13_M_deallocateEPS5_m(%"struct.std::_Vector_base"* %this1, %"class.std::__cxx11::basic_string"* %0, i64 %sub.ptr.div)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %_M_impl5 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  call void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl5) #2
  ret void

lpad:                                             ; preds = %entry
  %3 = landingpad { i8*, i32 }
          catch i8* null
  %4 = extractvalue { i8*, i32 } %3, 0
  store i8* %4, i8** %exn.slot, align 8
  %5 = extractvalue { i8*, i32 } %3, 1
  store i32 %5, i32* %ehselector.slot, align 4
  %_M_impl6 = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  call void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl6) #2
  br label %terminate.handler

terminate.handler:                                ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  call void @__clang_call_terminate(i8* %exn) #12
  unreachable
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #8 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #2
  call void @_ZSt9terminatev() #12
  unreachable
}

declare dso_local i8* @__cxa_begin_catch(i8*)

declare dso_local void @_ZSt9terminatev()

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZSt8_DestroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEvT_S7_(%"class.std::__cxx11::basic_string"* %__first, %"class.std::__cxx11::basic_string"* %__last) #6 comdat {
entry:
  %__first.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %__last.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  store %"class.std::__cxx11::basic_string"* %__first, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  store %"class.std::__cxx11::basic_string"* %__last, %"class.std::__cxx11::basic_string"** %__last.addr, align 8
  %0 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  %1 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__last.addr, align 8
  call void @_ZNSt12_Destroy_auxILb0EE9__destroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEvT_S9_(%"class.std::__cxx11::basic_string"* %0, %"class.std::__cxx11::basic_string"* %1)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Destroy_auxILb0EE9__destroyIPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEvT_S9_(%"class.std::__cxx11::basic_string"* %__first, %"class.std::__cxx11::basic_string"* %__last) #6 comdat align 2 {
entry:
  %__first.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %__last.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  store %"class.std::__cxx11::basic_string"* %__first, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  store %"class.std::__cxx11::basic_string"* %__last, %"class.std::__cxx11::basic_string"** %__last.addr, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  %1 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__last.addr, align 8
  %cmp = icmp ne %"class.std::__cxx11::basic_string"* %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  %call = call %"class.std::__cxx11::basic_string"* @_ZSt11__addressofINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEPT_RS6_(%"class.std::__cxx11::basic_string"* dereferenceable(32) %2) #2
  call void @_ZSt8_DestroyINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEvPT_(%"class.std::__cxx11::basic_string"* %call)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  %incdec.ptr = getelementptr inbounds %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string"* %3, i32 1
  store %"class.std::__cxx11::basic_string"* %incdec.ptr, %"class.std::__cxx11::basic_string"** %__first.addr, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZSt8_DestroyINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEvPT_(%"class.std::__cxx11::basic_string"* %__pointer) #1 comdat {
entry:
  %__pointer.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  store %"class.std::__cxx11::basic_string"* %__pointer, %"class.std::__cxx11::basic_string"** %__pointer.addr, align 8
  %0 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__pointer.addr, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.std::__cxx11::basic_string"* @_ZSt11__addressofINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEPT_RS6_(%"class.std::__cxx11::basic_string"* dereferenceable(32) %__r) #1 comdat {
entry:
  %__r.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  store %"class.std::__cxx11::basic_string"* %__r, %"class.std::__cxx11::basic_string"** %__r.addr, align 8
  %0 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__r.addr, align 8
  %1 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  %2 = bitcast i8* %1 to %"class.std::__cxx11::basic_string"*
  ret %"class.std::__cxx11::basic_string"* %2
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE13_M_deallocateEPS5_m(%"struct.std::_Vector_base"* %this, %"class.std::__cxx11::basic_string"* %__p, i64 %__n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"struct.std::_Vector_base"*, align 8
  %__p.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %__n.addr = alloca i64, align 8
  store %"struct.std::_Vector_base"* %this, %"struct.std::_Vector_base"** %this.addr, align 8
  store %"class.std::__cxx11::basic_string"* %__p, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  store i64 %__n, i64* %__n.addr, align 8
  %this1 = load %"struct.std::_Vector_base"*, %"struct.std::_Vector_base"** %this.addr, align 8
  %0 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  %tobool = icmp ne %"class.std::__cxx11::basic_string"* %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %_M_impl = getelementptr inbounds %"struct.std::_Vector_base", %"struct.std::_Vector_base"* %this1, i32 0, i32 0
  %1 = bitcast %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %_M_impl to %"class.std::allocator.6"*
  %2 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  %3 = load i64, i64* %__n.addr, align 8
  call void @_ZNSt16allocator_traitsISaINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEE10deallocateERS6_PS5_m(%"class.std::allocator.6"* dereferenceable(1) %1, %"class.std::__cxx11::basic_string"* %2, i64 %3)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt12_Vector_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESaIS5_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %this, %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"** %this.addr, align 8
  %this1 = load %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"*, %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"** %this.addr, align 8
  %0 = bitcast %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl"* %this1 to %"class.std::allocator.6"*
  call void @_ZNSaINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEED2Ev(%"class.std::allocator.6"* %0) #2
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEE10deallocateERS6_PS5_m(%"class.std::allocator.6"* dereferenceable(1) %__a, %"class.std::__cxx11::basic_string"* %__p, i64 %__n) #6 comdat align 2 {
entry:
  %__a.addr = alloca %"class.std::allocator.6"*, align 8
  %__p.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %__n.addr = alloca i64, align 8
  store %"class.std::allocator.6"* %__a, %"class.std::allocator.6"** %__a.addr, align 8
  store %"class.std::__cxx11::basic_string"* %__p, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  store i64 %__n, i64* %__n.addr, align 8
  %0 = load %"class.std::allocator.6"*, %"class.std::allocator.6"** %__a.addr, align 8
  %1 = bitcast %"class.std::allocator.6"* %0 to %"class.__gnu_cxx::new_allocator.7"*
  %2 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  %3 = load i64, i64* %__n.addr, align 8
  call void @_ZN9__gnu_cxx13new_allocatorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE10deallocateEPS6_m(%"class.__gnu_cxx::new_allocator.7"* %1, %"class.std::__cxx11::basic_string"* %2, i64 %3)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE10deallocateEPS6_m(%"class.__gnu_cxx::new_allocator.7"* %this, %"class.std::__cxx11::basic_string"* %__p, i64) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.__gnu_cxx::new_allocator.7"*, align 8
  %__p.addr = alloca %"class.std::__cxx11::basic_string"*, align 8
  %.addr = alloca i64, align 8
  store %"class.__gnu_cxx::new_allocator.7"* %this, %"class.__gnu_cxx::new_allocator.7"** %this.addr, align 8
  store %"class.std::__cxx11::basic_string"* %__p, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  store i64 %0, i64* %.addr, align 8
  %this1 = load %"class.__gnu_cxx::new_allocator.7"*, %"class.__gnu_cxx::new_allocator.7"** %this.addr, align 8
  %1 = load %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"** %__p.addr, align 8
  %2 = bitcast %"class.std::__cxx11::basic_string"* %1 to i8*
  call void @_ZdlPv(i8* %2) #2
  ret void
}

; Function Attrs: nobuiltin nounwind
declare dso_local void @_ZdlPv(i8*) #9

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSaINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEED2Ev(%"class.std::allocator.6"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::allocator.6"*, align 8
  store %"class.std::allocator.6"* %this, %"class.std::allocator.6"** %this.addr, align 8
  %this1 = load %"class.std::allocator.6"*, %"class.std::allocator.6"** %this.addr, align 8
  %0 = bitcast %"class.std::allocator.6"* %this1 to %"class.__gnu_cxx::new_allocator.7"*
  call void @_ZN9__gnu_cxx13new_allocatorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEED2Ev(%"class.__gnu_cxx::new_allocator.7"* %0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEED2Ev(%"class.__gnu_cxx::new_allocator.7"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.__gnu_cxx::new_allocator.7"*, align 8
  store %"class.__gnu_cxx::new_allocator.7"* %this, %"class.__gnu_cxx::new_allocator.7"** %this.addr, align 8
  %this1 = load %"class.__gnu_cxx::new_allocator.7"*, %"class.__gnu_cxx::new_allocator.7"** %this.addr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EED2Ev(%"class.std::_Rb_tree"* %this) unnamed_addr #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  %call = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_beginEv(%"class.std::_Rb_tree"* %this1) #2
  invoke void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_eraseEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this1, %"struct.std::_Rb_tree_node"* %call)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %_M_impl = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %this1, i32 0, i32 0
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE13_Rb_tree_implISC_Lb1EED2Ev(%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %_M_impl) #2
  ret void

lpad:                                             ; preds = %entry
  %0 = landingpad { i8*, i32 }
          catch i8* null
  %1 = extractvalue { i8*, i32 } %0, 0
  store i8* %1, i8** %exn.slot, align 8
  %2 = extractvalue { i8*, i32 } %0, 1
  store i32 %2, i32* %ehselector.slot, align 4
  %_M_impl2 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %this1, i32 0, i32 0
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE13_Rb_tree_implISC_Lb1EED2Ev(%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %_M_impl2) #2
  br label %terminate.handler

terminate.handler:                                ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  call void @__clang_call_terminate(i8* %exn) #12
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_eraseEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this, %"struct.std::_Rb_tree_node"* %__x) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  %__x.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  %__y = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  store %"struct.std::_Rb_tree_node"* %__x, %"struct.std::_Rb_tree_node"** %__x.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__x.addr, align 8
  %cmp = icmp ne %"struct.std::_Rb_tree_node"* %0, null
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__x.addr, align 8
  %2 = bitcast %"struct.std::_Rb_tree_node"* %1 to %"struct.std::_Rb_tree_node_base"*
  %call = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %2) #2
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_eraseEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this1, %"struct.std::_Rb_tree_node"* %call)
  %3 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__x.addr, align 8
  %4 = bitcast %"struct.std::_Rb_tree_node"* %3 to %"struct.std::_Rb_tree_node_base"*
  %call2 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE7_S_leftEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %4) #2
  store %"struct.std::_Rb_tree_node"* %call2, %"struct.std::_Rb_tree_node"** %__y, align 8
  %5 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__x.addr, align 8
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this1, %"struct.std::_Rb_tree_node"* %5) #2
  %6 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__y, align 8
  store %"struct.std::_Rb_tree_node"* %6, %"struct.std::_Rb_tree_node"** %__x.addr, align 8
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_M_beginEv(%"class.std::_Rb_tree"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  %_M_impl = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %this1, i32 0, i32 0
  %_M_header = getelementptr inbounds %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl", %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %_M_impl, i32 0, i32 1
  %_M_parent = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %_M_header, i32 0, i32 1
  %0 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %_M_parent, align 8
  %1 = bitcast %"struct.std::_Rb_tree_node_base"* %0 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %1
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE13_Rb_tree_implISC_Lb1EED2Ev(%"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"*, align 8
  store %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %this, %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"** %this.addr, align 8
  %this1 = load %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"*, %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"** %this.addr, align 8
  %0 = bitcast %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %this1 to %"class.std::allocator"*
  call void @_ZNSaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_EEED2Ev(%"class.std::allocator"* %0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %__x) #1 comdat align 2 {
entry:
  %__x.addr = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"struct.std::_Rb_tree_node_base"* %__x, %"struct.std::_Rb_tree_node_base"** %__x.addr, align 8
  %0 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %__x.addr, align 8
  %_M_right = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %0, i32 0, i32 3
  %1 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %_M_right, align 8
  %2 = bitcast %"struct.std::_Rb_tree_node_base"* %1 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %2
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE7_S_leftEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %__x) #1 comdat align 2 {
entry:
  %__x.addr = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"struct.std::_Rb_tree_node_base"* %__x, %"struct.std::_Rb_tree_node_base"** %__x.addr, align 8
  %0 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %__x.addr, align 8
  %_M_left = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %0, i32 0, i32 2
  %1 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %_M_left, align 8
  %2 = bitcast %"struct.std::_Rb_tree_node_base"* %1 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %2
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this, %"struct.std::_Rb_tree_node"* %__p) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  %__p.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  store %"struct.std::_Rb_tree_node"* %__p, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  %0 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE15_M_destroy_nodeEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this1, %"struct.std::_Rb_tree_node"* %0) #2
  %1 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  call void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this1, %"struct.std::_Rb_tree_node"* %1) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE15_M_destroy_nodeEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this, %"struct.std::_Rb_tree_node"* %__p) #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  %__p.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  store %"struct.std::_Rb_tree_node"* %__p, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  %call = call dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %this1) #2
  %0 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  %call2 = invoke %"struct.std::pair"* @_ZNSt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_EE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %0)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  invoke void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EEEE7destroyIS9_EEvRSB_PT_(%"class.std::allocator"* dereferenceable(1) %call, %"struct.std::pair"* %call2)
          to label %invoke.cont3 unwind label %terminate.lpad

invoke.cont3:                                     ; preds = %invoke.cont
  %1 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  ret void

terminate.lpad:                                   ; preds = %invoke.cont, %entry
  %2 = landingpad { i8*, i32 }
          catch i8* null
  %3 = extractvalue { i8*, i32 } %2, 0
  call void @__clang_call_terminate(i8* %3) #12
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS8_E(%"class.std::_Rb_tree"* %this, %"struct.std::_Rb_tree_node"* %__p) #1 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  %__p.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  store %"struct.std::_Rb_tree_node"* %__p, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  %call = call dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %this1) #2
  %0 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  invoke void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EEEE10deallocateERSB_PSA_m(%"class.std::allocator"* dereferenceable(1) %call, %"struct.std::_Rb_tree_node"* %0, i64 1)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  ret void

terminate.lpad:                                   ; preds = %entry
  %1 = landingpad { i8*, i32 }
          catch i8* null
  %2 = extractvalue { i8*, i32 } %1, 0
  call void @__clang_call_terminate(i8* %2) #12
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EEEE7destroyIS9_EEvRSB_PT_(%"class.std::allocator"* dereferenceable(1) %__a, %"struct.std::pair"* %__p) #6 comdat align 2 {
entry:
  %__a.addr = alloca %"class.std::allocator"*, align 8
  %__p.addr = alloca %"struct.std::pair"*, align 8
  store %"class.std::allocator"* %__a, %"class.std::allocator"** %__a.addr, align 8
  store %"struct.std::pair"* %__p, %"struct.std::pair"** %__p.addr, align 8
  %0 = load %"class.std::allocator"*, %"class.std::allocator"** %__a.addr, align 8
  %1 = bitcast %"class.std::allocator"* %0 to %"class.__gnu_cxx::new_allocator"*
  %2 = load %"struct.std::pair"*, %"struct.std::pair"** %__p.addr, align 8
  call void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEE7destroyISA_EEvPT_(%"class.__gnu_cxx::new_allocator"* %1, %"struct.std::pair"* %2)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_S5_ESt10_Select1stIS8_ESt4lessIS5_ESaIS8_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %this, %"class.std::_Rb_tree"** %this.addr, align 8
  %this1 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %this.addr, align 8
  %_M_impl = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %this1, i32 0, i32 0
  %0 = bitcast %"struct.std::_Rb_tree<std::__cxx11::basic_string<char>, std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> >, std::_Select1st<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > >, std::less<std::__cxx11::basic_string<char> >, std::allocator<std::pair<const std::__cxx11::basic_string<char>, std::__cxx11::basic_string<char> > > >::_Rb_tree_impl"* %_M_impl to %"class.std::allocator"*
  ret %"class.std::allocator"* %0
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.std::pair"* @_ZNSt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_EE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"struct.std::_Rb_tree_node"* %this, %"struct.std::_Rb_tree_node"** %this.addr, align 8
  %this1 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %this.addr, align 8
  %_M_storage = getelementptr inbounds %"struct.std::_Rb_tree_node", %"struct.std::_Rb_tree_node"* %this1, i32 0, i32 1
  %call = call %"struct.std::pair"* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf"* %_M_storage) #2
  ret %"struct.std::pair"* %call
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEE7destroyISA_EEvPT_(%"class.__gnu_cxx::new_allocator"* %this, %"struct.std::pair"* %__p) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  %__p.addr = alloca %"struct.std::pair"*, align 8
  store %"class.__gnu_cxx::new_allocator"* %this, %"class.__gnu_cxx::new_allocator"** %this.addr, align 8
  store %"struct.std::pair"* %__p, %"struct.std::pair"** %__p.addr, align 8
  %this1 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %this.addr, align 8
  %0 = load %"struct.std::pair"*, %"struct.std::pair"** %__p.addr, align 8
  call void @_ZNSt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_ED2Ev(%"struct.std::pair"* %0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES5_ED2Ev(%"struct.std::pair"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.std::pair"*, align 8
  store %"struct.std::pair"* %this, %"struct.std::pair"** %this.addr, align 8
  %this1 = load %"struct.std::pair"*, %"struct.std::pair"** %this.addr, align 8
  %second = getelementptr inbounds %"struct.std::pair", %"struct.std::pair"* %this1, i32 0, i32 1
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %second) #2
  %first = getelementptr inbounds %"struct.std::pair", %"struct.std::pair"* %this1, i32 0, i32 0
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %first) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.std::pair"* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.__gnu_cxx::__aligned_membuf"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf"* %this, %"struct.__gnu_cxx::__aligned_membuf"** %this.addr, align 8
  %this1 = load %"struct.__gnu_cxx::__aligned_membuf"*, %"struct.__gnu_cxx::__aligned_membuf"** %this.addr, align 8
  %call = call i8* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf"* %this1) #2
  %0 = bitcast i8* %call to %"struct.std::pair"*
  ret %"struct.std::pair"* %0
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf"* %this) #1 comdat align 2 {
entry:
  %this.addr = alloca %"struct.__gnu_cxx::__aligned_membuf"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf"* %this, %"struct.__gnu_cxx::__aligned_membuf"** %this.addr, align 8
  %this1 = load %"struct.__gnu_cxx::__aligned_membuf"*, %"struct.__gnu_cxx::__aligned_membuf"** %this.addr, align 8
  %_M_storage = getelementptr inbounds %"struct.__gnu_cxx::__aligned_membuf", %"struct.__gnu_cxx::__aligned_membuf"* %this1, i32 0, i32 0
  %0 = bitcast [64 x i8]* %_M_storage to i8*
  ret i8* %0
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES7_EEEE10deallocateERSB_PSA_m(%"class.std::allocator"* dereferenceable(1) %__a, %"struct.std::_Rb_tree_node"* %__p, i64 %__n) #6 comdat align 2 {
entry:
  %__a.addr = alloca %"class.std::allocator"*, align 8
  %__p.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  %__n.addr = alloca i64, align 8
  store %"class.std::allocator"* %__a, %"class.std::allocator"** %__a.addr, align 8
  store %"struct.std::_Rb_tree_node"* %__p, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  store i64 %__n, i64* %__n.addr, align 8
  %0 = load %"class.std::allocator"*, %"class.std::allocator"** %__a.addr, align 8
  %1 = bitcast %"class.std::allocator"* %0 to %"class.__gnu_cxx::new_allocator"*
  %2 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  %3 = load i64, i64* %__n.addr, align 8
  call void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEE10deallocateEPSB_m(%"class.__gnu_cxx::new_allocator"* %1, %"struct.std::_Rb_tree_node"* %2, i64 %3)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEE10deallocateEPSB_m(%"class.__gnu_cxx::new_allocator"* %this, %"struct.std::_Rb_tree_node"* %__p, i64) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  %__p.addr = alloca %"struct.std::_Rb_tree_node"*, align 8
  %.addr = alloca i64, align 8
  store %"class.__gnu_cxx::new_allocator"* %this, %"class.__gnu_cxx::new_allocator"** %this.addr, align 8
  store %"struct.std::_Rb_tree_node"* %__p, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  store i64 %0, i64* %.addr, align 8
  %this1 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %this.addr, align 8
  %1 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %__p.addr, align 8
  %2 = bitcast %"struct.std::_Rb_tree_node"* %1 to i8*
  call void @_ZdlPv(i8* %2) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSaISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_EEED2Ev(%"class.std::allocator"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::allocator"*, align 8
  store %"class.std::allocator"* %this, %"class.std::allocator"** %this.addr, align 8
  %this1 = load %"class.std::allocator"*, %"class.std::allocator"** %this.addr, align 8
  %0 = bitcast %"class.std::allocator"* %this1 to %"class.__gnu_cxx::new_allocator"*
  call void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEED2Ev(%"class.__gnu_cxx::new_allocator"* %0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_EEED2Ev(%"class.__gnu_cxx::new_allocator"* %this) unnamed_addr #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  store %"class.__gnu_cxx::new_allocator"* %this, %"class.__gnu_cxx::new_allocator"** %this.addr, align 8
  %this1 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %this.addr, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP17_cl_command_queueE5resetEPS2_(%"class.aocl_utils::scoped_array.0"* %this, %struct._cl_command_queue** %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.0"*, align 8
  %ptr.addr = alloca %struct._cl_command_queue**, align 8
  store %"class.aocl_utils::scoped_array.0"* %this, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  store %struct._cl_command_queue** %ptr, %struct._cl_command_queue*** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.0"*, %"class.aocl_utils::scoped_array.0"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.0", %"class.aocl_utils::scoped_array.0"* %this1, i32 0, i32 0
  %0 = load %struct._cl_command_queue**, %struct._cl_command_queue*** %m_ptr, align 8
  %isnull = icmp eq %struct._cl_command_queue** %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast %struct._cl_command_queue** %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load %struct._cl_command_queue**, %struct._cl_command_queue*** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array.0", %"class.aocl_utils::scoped_array.0"* %this1, i32 0, i32 0
  store %struct._cl_command_queue** %2, %struct._cl_command_queue*** %m_ptr2, align 8
  ret void
}

; Function Attrs: nobuiltin nounwind
declare dso_local void @_ZdaPv(i8*) #9

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP10_cl_kernelE5resetEPS2_(%"class.aocl_utils::scoped_array.1"* %this, %struct._cl_kernel** %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.1"*, align 8
  %ptr.addr = alloca %struct._cl_kernel**, align 8
  store %"class.aocl_utils::scoped_array.1"* %this, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  store %struct._cl_kernel** %ptr, %struct._cl_kernel*** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.1"*, %"class.aocl_utils::scoped_array.1"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.1", %"class.aocl_utils::scoped_array.1"* %this1, i32 0, i32 0
  %0 = load %struct._cl_kernel**, %struct._cl_kernel*** %m_ptr, align 8
  %isnull = icmp eq %struct._cl_kernel** %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast %struct._cl_kernel** %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load %struct._cl_kernel**, %struct._cl_kernel*** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array.1", %"class.aocl_utils::scoped_array.1"* %this1, i32 0, i32 0
  store %struct._cl_kernel** %2, %struct._cl_kernel*** %m_ptr2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP7_cl_memE5resetEPS2_(%"class.aocl_utils::scoped_array.2"* %this, %struct._cl_mem** %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.2"*, align 8
  %ptr.addr = alloca %struct._cl_mem**, align 8
  store %"class.aocl_utils::scoped_array.2"* %this, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  store %struct._cl_mem** %ptr, %struct._cl_mem*** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.2"*, %"class.aocl_utils::scoped_array.2"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.2", %"class.aocl_utils::scoped_array.2"* %this1, i32 0, i32 0
  %0 = load %struct._cl_mem**, %struct._cl_mem*** %m_ptr, align 8
  %isnull = icmp eq %struct._cl_mem** %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast %struct._cl_mem** %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load %struct._cl_mem**, %struct._cl_mem*** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array.2", %"class.aocl_utils::scoped_array.2"* %this1, i32 0, i32 0
  store %struct._cl_mem** %2, %struct._cl_mem*** %m_ptr2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayINS_18scoped_aligned_ptrIfEEE5resetEPS2_(%"class.aocl_utils::scoped_array.3"* %this, %"class.aocl_utils::scoped_aligned_ptr"* %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.3"*, align 8
  %ptr.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  store %"class.aocl_utils::scoped_array.3"* %this, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  store %"class.aocl_utils::scoped_aligned_ptr"* %ptr, %"class.aocl_utils::scoped_aligned_ptr"** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.3"*, %"class.aocl_utils::scoped_array.3"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.3", %"class.aocl_utils::scoped_array.3"* %this1, i32 0, i32 0
  %0 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %m_ptr, align 8
  %isnull = icmp eq %"class.aocl_utils::scoped_aligned_ptr"* %0, null
  br i1 %isnull, label %delete.end3, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast %"class.aocl_utils::scoped_aligned_ptr"* %0 to i8*
  %2 = getelementptr inbounds i8, i8* %1, i64 -8
  %3 = bitcast i8* %2 to i64*
  %4 = load i64, i64* %3, align 8
  %delete.end = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %0, i64 %4
  %arraydestroy.isempty = icmp eq %"class.aocl_utils::scoped_aligned_ptr"* %0, %delete.end
  br i1 %arraydestroy.isempty, label %arraydestroy.done2, label %arraydestroy.body

arraydestroy.body:                                ; preds = %arraydestroy.body, %delete.notnull
  %arraydestroy.elementPast = phi %"class.aocl_utils::scoped_aligned_ptr"* [ %delete.end, %delete.notnull ], [ %arraydestroy.element, %arraydestroy.body ]
  %arraydestroy.element = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %arraydestroy.elementPast, i64 -1
  call void @_ZN10aocl_utils18scoped_aligned_ptrIfED2Ev(%"class.aocl_utils::scoped_aligned_ptr"* %arraydestroy.element) #2
  %arraydestroy.done = icmp eq %"class.aocl_utils::scoped_aligned_ptr"* %arraydestroy.element, %0
  br i1 %arraydestroy.done, label %arraydestroy.done2, label %arraydestroy.body

arraydestroy.done2:                               ; preds = %arraydestroy.body, %delete.notnull
  call void @_ZdaPv(i8* %2) #13
  br label %delete.end3

delete.end3:                                      ; preds = %arraydestroy.done2, %entry
  %5 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %ptr.addr, align 8
  %m_ptr4 = getelementptr inbounds %"class.aocl_utils::scoped_array.3", %"class.aocl_utils::scoped_array.3"* %this1, i32 0, i32 0
  store %"class.aocl_utils::scoped_aligned_ptr"* %5, %"class.aocl_utils::scoped_aligned_ptr"** %m_ptr4, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils18scoped_aligned_ptrIfE5resetEPf(%"class.aocl_utils::scoped_aligned_ptr"* %this, float* %ptr) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_aligned_ptr"*, align 8
  %ptr.addr = alloca float*, align 8
  store %"class.aocl_utils::scoped_aligned_ptr"* %this, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  store float* %ptr, float** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_aligned_ptr"*, %"class.aocl_utils::scoped_aligned_ptr"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %this1, i32 0, i32 0
  %0 = load float*, float** %m_ptr, align 8
  %tobool = icmp ne float* %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %this1, i32 0, i32 0
  %1 = load float*, float** %m_ptr2, align 8
  %2 = bitcast float* %1 to i8*
  call void @_ZN10aocl_utils11alignedFreeEPv(i8* %2)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %3 = load float*, float** %ptr.addr, align 8
  %m_ptr3 = getelementptr inbounds %"class.aocl_utils::scoped_aligned_ptr", %"class.aocl_utils::scoped_aligned_ptr"* %this1, i32 0, i32 0
  store float* %3, float** %m_ptr3, align 8
  ret void
}

declare dso_local void @_ZN10aocl_utils11alignedFreeEPv(i8*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIfE5resetEPf(%"class.aocl_utils::scoped_array.4"* %this, float* %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.4"*, align 8
  %ptr.addr = alloca float*, align 8
  store %"class.aocl_utils::scoped_array.4"* %this, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  store float* %ptr, float** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.4"*, %"class.aocl_utils::scoped_array.4"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.4", %"class.aocl_utils::scoped_array.4"* %this1, i32 0, i32 0
  %0 = load float*, float** %m_ptr, align 8
  %isnull = icmp eq float* %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast float* %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load float*, float** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array.4", %"class.aocl_utils::scoped_array.4"* %this1, i32 0, i32 0
  store float* %2, float** %m_ptr2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIjE5resetEPj(%"class.aocl_utils::scoped_array.5"* %this, i32* %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.5"*, align 8
  %ptr.addr = alloca i32*, align 8
  store %"class.aocl_utils::scoped_array.5"* %this, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  store i32* %ptr, i32** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.5"*, %"class.aocl_utils::scoped_array.5"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.5", %"class.aocl_utils::scoped_array.5"* %this1, i32 0, i32 0
  %0 = load i32*, i32** %m_ptr, align 8
  %isnull = icmp eq i32* %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast i32* %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load i32*, i32** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array.5", %"class.aocl_utils::scoped_array.5"* %this1, i32 0, i32 0
  store i32* %2, i32** %m_ptr2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZStorSt13_Ios_OpenmodeS_(i32 %__a, i32 %__b) #1 comdat {
entry:
  %__a.addr = alloca i32, align 4
  %__b.addr = alloca i32, align 4
  store i32 %__a, i32* %__a.addr, align 4
  store i32 %__b, i32* %__b.addr, align 4
  %0 = load i32, i32* %__a.addr, align 4
  %1 = load i32, i32* %__b.addr, align 4
  %or = or i32 %0, %1
  ret i32 %or
}

declare dso_local void @_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode(%"class.std::__cxx11::basic_stringstream"*, i32) unnamed_addr #4

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE(%"class.std::basic_ostream"* dereferenceable(272), %"class.std::__cxx11::basic_string"* dereferenceable(32)) #4

declare dso_local dereferenceable(32) %"class.std::__cxx11::basic_string"* @_ZNK10aocl_utils7Options3getERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"*, %"class.std::__cxx11::basic_string"* dereferenceable(32)) #4

declare dso_local dereferenceable(280) %"class.std::basic_istream"* @_ZNSirsERj(%"class.std::basic_istream"*, i32* dereferenceable(4)) #4

declare dso_local zeroext i1 @_ZNKSt9basic_iosIcSt11char_traitsIcEE4failEv(%"class.std::basic_ios"*) #4

declare dso_local zeroext i1 @_ZNKSt9basic_iosIcSt11char_traitsIcEE3eofEv(%"class.std::basic_ios"*) #4

declare dso_local void @_ZNK10aocl_utils7Options14errorWrongTypeERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(%"class.aocl_utils::Options"*, %"class.std::__cxx11::basic_string"* dereferenceable(32)) #4

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_stringstream"*) unnamed_addr #5

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #10

; Function Attrs: nobuiltin
declare dso_local noalias i8* @_Znam(i64) #11

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #10

declare dso_local i8* @_ZN10aocl_utils13alignedMallocEm(i64) #4

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEm(%"class.aocl_utils::scoped_array.12"* %this, i64 %n) #6 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.12"*, align 8
  %n.addr = alloca i64, align 8
  store %"class.aocl_utils::scoped_array.12"* %this, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  store i64 %n, i64* %n.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.12"*, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %0 = load i64, i64* %n.addr, align 8
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 8)
  %2 = extractvalue { i64, i1 } %1, 1
  %3 = extractvalue { i64, i1 } %1, 0
  %4 = select i1 %2, i64 -1, i64 %3
  %call = call i8* @_Znam(i64 %4) #14
  %5 = bitcast i8* %call to %struct._cl_event**
  call void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEPS2_(%"class.aocl_utils::scoped_array.12"* %this1, %struct._cl_event** %5)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN10aocl_utils12scoped_arrayIP9_cl_eventE5resetEPS2_(%"class.aocl_utils::scoped_array.12"* %this, %struct._cl_event** %ptr) #1 comdat align 2 {
entry:
  %this.addr = alloca %"class.aocl_utils::scoped_array.12"*, align 8
  %ptr.addr = alloca %struct._cl_event**, align 8
  store %"class.aocl_utils::scoped_array.12"* %this, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  store %struct._cl_event** %ptr, %struct._cl_event*** %ptr.addr, align 8
  %this1 = load %"class.aocl_utils::scoped_array.12"*, %"class.aocl_utils::scoped_array.12"** %this.addr, align 8
  %m_ptr = getelementptr inbounds %"class.aocl_utils::scoped_array.12", %"class.aocl_utils::scoped_array.12"* %this1, i32 0, i32 0
  %0 = load %struct._cl_event**, %struct._cl_event*** %m_ptr, align 8
  %isnull = icmp eq %struct._cl_event** %0, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %entry
  %1 = bitcast %struct._cl_event** %0 to i8*
  call void @_ZdaPv(i8* %1) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %entry
  %2 = load %struct._cl_event**, %struct._cl_event*** %ptr.addr, align 8
  %m_ptr2 = getelementptr inbounds %"class.aocl_utils::scoped_array.12", %"class.aocl_utils::scoped_array.12"* %this1, i32 0, i32 0
  store %struct._cl_event** %2, %struct._cl_event*** %m_ptr2, align 8
  ret void
}

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_main.cpp() #0 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  call void @__cxx_global_var_init.1()
  call void @__cxx_global_var_init.2()
  call void @__cxx_global_var_init.3()
  call void @__cxx_global_var_init.4()
  call void @__cxx_global_var_init.5()
  call void @__cxx_global_var_init.6()
  call void @__cxx_global_var_init.7()
  call void @__cxx_global_var_init.8()
  call void @__cxx_global_var_init.9()
  call void @__cxx_global_var_init.10()
  ret void
}

attributes #0 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { noinline norecurse optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { argmemonly nounwind }
attributes #8 = { noinline noreturn nounwind }
attributes #9 = { nobuiltin nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nounwind readnone speculatable }
attributes #11 = { nobuiltin "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #12 = { noreturn nounwind }
attributes #13 = { builtin nounwind }
attributes #14 = { builtin }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 75afc0105c089171f9d85d59038617fb222c38cd)"}
