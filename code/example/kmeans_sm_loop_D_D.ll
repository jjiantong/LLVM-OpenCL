; ModuleID = 'kmeans_sm_loop_D_D.cl'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600"

@kmeans_kernel_c.l_clusters = internal addrspace(3) unnamed_addr global [1024 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define void @kmeans_kernel_c(float addrspace(1)* noalias nocapture readonly %feature, float addrspace(1)* noalias nocapture readonly %clusters, i32 addrspace(1)* noalias nocapture %membership, i32 %npoints, i32 %nclusters, i32 %nfeatures, i32 %offset, i32 %size) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = icmp ult i32 %2, %nclusters
  br i1 %3, label %4, label %17

; <label>:4                                       ; preds = %0
  %5 = shl i32 %2, 3
  %6 = getelementptr inbounds float addrspace(1)* %clusters, i32 %5
  %7 = getelementptr inbounds [1024 x float] addrspace(3)* @kmeans_kernel_c.l_clusters, i32 0, i32 %5
  %8 = bitcast float addrspace(1)* %6 to <4 x float> addrspace(1)*
  %9 = load <4 x float> addrspace(1)* %8, align 4, !tbaa !2
  %10 = bitcast float addrspace(3)* %7 to <4 x float> addrspace(3)*
  store <4 x float> %9, <4 x float> addrspace(3)* %10, align 4, !tbaa !2
  %11 = or i32 %5, 4
  %12 = getelementptr inbounds float addrspace(1)* %clusters, i32 %11
  %13 = getelementptr inbounds [1024 x float] addrspace(3)* @kmeans_kernel_c.l_clusters, i32 0, i32 %11
  %14 = bitcast float addrspace(1)* %12 to <4 x float> addrspace(1)*
  %15 = load <4 x float> addrspace(1)* %14, align 4, !tbaa !2
  %16 = bitcast float addrspace(3)* %13 to <4 x float> addrspace(3)*
  store <4 x float> %15, <4 x float> addrspace(3)* %16, align 4, !tbaa !2
  br label %17

; <label>:17                                      ; preds = %4, %0
  tail call void @barrier(i32 1) #2
  %18 = tail call i32 @get_global_size(i32 0) #2
  %19 = tail call i32 @get_global_id(i32 0) #2
  %20 = icmp ult i32 %19, %npoints
  br i1 %20, label %.preheader3.lr.ph, label %._crit_edge11

.preheader3.lr.ph:                                ; preds = %17
  %21 = icmp sgt i32 %nclusters, 0
  %22 = icmp sgt i32 %nfeatures, 0
  br label %.preheader3

.preheader3:                                      ; preds = %.preheader3.lr.ph, %._crit_edge7
  %point_id.010 = phi i32 [ %19, %.preheader3.lr.ph ], [ %39, %._crit_edge7 ]
  %index.09 = phi i32 [ 0, %.preheader3.lr.ph ], [ %index.1.lcssa, %._crit_edge7 ]
  br i1 %21, label %.preheader, label %._crit_edge7

.preheader:                                       ; preds = %.preheader3, %._crit_edge
  %index.16 = phi i32 [ %index.2, %._crit_edge ], [ %index.09, %.preheader3 ]
  %min_dist.05 = phi float [ %min_dist.1, %._crit_edge ], [ 0x47EFFFFFE0000000, %.preheader3 ]
  %i.04 = phi i32 [ %37, %._crit_edge ], [ 0, %.preheader3 ]
  br i1 %22, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %23 = mul nsw i32 %i.04, %nfeatures
  br label %24

; <label>:24                                      ; preds = %24, %.lr.ph
  %l.02 = phi i32 [ 0, %.lr.ph ], [ %35, %24 ]
  %ans.01 = phi float [ 0.000000e+00, %.lr.ph ], [ %34, %24 ]
  %25 = add nsw i32 %l.02, %23
  %26 = getelementptr inbounds [1024 x float] addrspace(3)* @kmeans_kernel_c.l_clusters, i32 0, i32 %25
  %27 = load float addrspace(3)* %26, align 4, !tbaa !2
  %28 = mul nsw i32 %l.02, %npoints
  %29 = add i32 %28, %point_id.010
  %30 = getelementptr inbounds float addrspace(1)* %feature, i32 %29
  %31 = load float addrspace(1)* %30, align 4, !tbaa !2
  %32 = fsub float %31, %27
  %33 = fmul float %32, %32
  %34 = fadd float %ans.01, %33
  %35 = add nsw i32 %l.02, 1
  %exitcond = icmp eq i32 %35, %nfeatures
  br i1 %exitcond, label %._crit_edge, label %24

._crit_edge:                                      ; preds = %24, %.preheader
  %ans.0.lcssa = phi float [ 0.000000e+00, %.preheader ], [ %34, %24 ]
  %36 = fcmp olt float %ans.0.lcssa, %min_dist.05
  %min_dist.1 = select i1 %36, float %ans.0.lcssa, float %min_dist.05
  %index.2 = select i1 %36, i32 %i.04, i32 %index.16
  %37 = add nsw i32 %i.04, 1
  %exitcond12 = icmp eq i32 %37, %nclusters
  br i1 %exitcond12, label %._crit_edge7, label %.preheader

._crit_edge7:                                     ; preds = %._crit_edge, %.preheader3
  %index.1.lcssa = phi i32 [ %index.09, %.preheader3 ], [ %index.2, %._crit_edge ]
  %38 = getelementptr inbounds i32 addrspace(1)* %membership, i32 %point_id.010
  store i32 %index.1.lcssa, i32 addrspace(1)* %38, align 4, !tbaa !6
  %39 = add i32 %point_id.010, %18
  %40 = icmp ult i32 %39, %npoints
  br i1 %40, label %.preheader3, label %._crit_edge11

._crit_edge11:                                    ; preds = %._crit_edge7, %17
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_size(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, i32 addrspace(1)*, i32, i32, i32, i32, i32)* @kmeans_kernel_c}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3~precise2 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}
