<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TrangDangNhap.aspx.cs" Inherits="WebBanLaptop.TrangDangNhap" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-4 my-lg-5">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-9 col-xl-8">
                <div class="card border-0 shadow rounded-4 overflow-hidden">
                    <div class="row g-0">
                        
                        <div class="col-md-5 bg-danger bg-gradient text-white p-4 p-lg-5 d-none d-md-flex flex-column justify-content-between">
                            <div>
                                <h3 class="fw-bold mb-3">Chào mừng bạn quay trở lại!</h3>
                                <p class="text-white-50 small mb-4">
                                    Đăng nhập để kiểm tra giỏ hàng, theo dõi đơn hàng và nhận ưu đãi dành riêng cho thành viên.
                                </p>

                                <div class="d-flex flex-column gap-3 mt-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <i class="bi bi-shield-check fs-3 text-warning"></i>
                                        <span class="small">Bảo hành chính hãng toàn quốc</span>
                                    </div>
                                    <div class="d-flex align-items-center gap-3">
                                        <i class="bi bi-truck fs-3 text-warning"></i>
                                        <span class="small">Giao hàng hỏa tốc nội thành</span>
                                    </div>
                                    <div class="d-flex align-items-center gap-3">
                                        <i class="bi bi-gift fs-3 text-warning"></i>
                                        <span class="small">Nhiều voucher giảm giá hấp dẫn</span>
                                    </div>
                                </div>
                            </div>

                            <div class="pt-3 border-top border-white border-opacity-25 small text-white-50">
                                <i class="bi bi-headset me-1"></i> Hỗ trợ: <strong class="text-white">0944.484.818</strong>
                            </div>
                        </div>

                        <div class="col-md-7 bg-white p-4 p-sm-5">
                            <div class="mb-4">
                                <h4 class="fw-bold text-danger mb-1">ĐĂNG NHẬP</h4>
                                <p class="text-secondary small mb-0">Nhập thông tin tài khoản của bạn</p>
                            </div>

                            <!-- Thông báo từ Server -->
                            <asp:Panel ID="pnlThongBao" runat="server" Visible="false" CssClass="alert rounded-3 py-2 small mb-3">
                                <asp:Label ID="lblThongBao" runat="server"></asp:Label>
                            </asp:Panel>

                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Tên đăng nhập <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person text-secondary"></i></span>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control py-2" Style="max-width: 100%;" placeholder="Nhập tên đăng nhập..."></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                                    ControlToValidate="txtUsername" 
                                    ValidationGroup="vgLogin"
                                    ErrorMessage="Vui lòng nhập tên đăng nhập!" 
                                    CssClass="text-danger small mt-1" 
                                    Display="Dynamic" />
                            </div>

                            <div class="mb-3">
                                <div class="d-flex justify-content-between">
                                    <label class="form-label fw-semibold small">Mật khẩu <span class="text-danger">*</span></label>
                                    <a href="#" class="text-danger text-decoration-none small">Quên mật khẩu?</a>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-lock text-secondary"></i></span>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control py-2" Style="max-width: 100%;" TextMode="Password" placeholder="Nhập mật khẩu..."></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                    ControlToValidate="txtPassword" 
                                    ValidationGroup="vgLogin"
                                    ErrorMessage="Vui lòng nhập mật khẩu!" 
                                    CssClass="text-danger small mt-1" 
                                    Display="Dynamic" />
                            </div>

                            <asp:Button ID="btnDangNhap" runat="server" Text="ĐĂNG NHẬP" 
                                ValidationGroup="vgLogin"
                                CssClass="btn btn-danger w-100 py-2 fw-bold rounded-3 shadow-sm mb-3" 
                                Style="max-width: 100%;"
                                OnClick="btnDangNhap_Click" />

                            <div class="text-center pt-3 border-top">
                                <span class="text-secondary small">Bạn chưa có tài khoản? </span>
                                <a href="TrangDangKy" class="text-danger fw-bold text-decoration-none small">Đăng ký ngay</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
