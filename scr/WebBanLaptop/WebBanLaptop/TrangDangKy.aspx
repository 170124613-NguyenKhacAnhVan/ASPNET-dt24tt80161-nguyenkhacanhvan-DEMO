<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TrangDangKy.aspx.cs" Inherits="WebBanLaptop.TrangDangKy" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-4 my-lg-5">
        <div class="row justify-content-center">
            <div class="col-12 col-xl-10">
                <div class="card border-0 shadow rounded-4 overflow-hidden">
                    <div class="row g-0">

                        <div class="col-lg-4 bg-danger bg-gradient text-white p-4 p-xl-5 d-none d-lg-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-warning text-dark mb-3 px-3 py-2 rounded-pill fw-bold">
                                    <i class="bi bi-person-plus-fill me-1"></i>THÀNH VIÊN MỚI
                                </span>
                                <h3 class="fw-bold mb-3">Đăng ký tài khoản</h3>
                                <p class="text-white-50 small mb-4">
                                    Tạo tài khoản ngay để nhận đặc quyền mua sắm:
                               
                                </p>

                                <ul class="list-unstyled d-flex flex-column gap-3 small">
                                    <li class="d-flex align-items-center gap-2">
                                        <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                                        <span>Tự động lưu địa chỉ giao hàng</span>
                                    </li>
                                    <li class="d-flex align-items-center gap-2">
                                        <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                                        <span>Tra cứu bảo hành bằng Số điện thoại</span>
                                    </li>
                                    <li class="d-flex align-items-center gap-2">
                                        <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                                        <span>Nhận thông báo khuyến mãi sớm nhất</span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-lg-8 bg-white p-4 p-sm-5">
                            <div class="mb-4">
                                <h4 class="fw-bold text-danger mb-1">ĐĂNG KÝ TÀI KHOẢN</h4>
                                <p class="text-secondary small mb-0">Điền thông tin bên dưới để tạo tài khoản mua hàng</p>
                            </div>

                            <asp:ValidationSummary ID="vsRegister" runat="server"
                                ValidationGroup="vgRegister"
                                HeaderText="Vui lòng kiểm tra lại các thông tin sau:"
                                CssClass="alert alert-warning rounded-3 py-2 small mb-3" />

                            <asp:Panel ID="pnlThongBao" runat="server" Visible="false" CssClass="alert alert-danger rounded-3 py-2 small mb-3">
                                <asp:Label ID="lblThongBao" runat="server"></asp:Label>
                            </asp:Panel>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Tên đăng nhập <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-person-badge text-secondary"></i></span>
                                        <asp:TextBox ID="txtUsername" runat="server" MaxLength="50" CssClass="form-control" Style="max-width: 100%;" placeholder="Viết liền, không dấu. Không thể thay đổi sau khi đăng ký."></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                                        ControlToValidate="txtUsername" ValidationGroup="vgRegister"
                                        ErrorMessage="Tên đăng nhập không được để trống!" Text="Vui lòng nhập tên đăng nhập."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revUsername" runat="server"
                                        ControlToValidate="txtUsername" ValidationGroup="vgRegister"
                                        ValidationExpression="^[a-zA-Z0-9_]{4,50}$"
                                        ErrorMessage="Tên đăng nhập gồm 4-50 ký tự (chữ không dấu, số, gạch dưới)!" Text="Từ 4-50 ký tự, viết liền không dấu."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Họ và tên <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-person text-secondary"></i></span>
                                        <asp:TextBox ID="txtFullname" runat="server" MaxLength="100" CssClass="form-control" Style="max-width: 100%;" placeholder="Nguyễn Văn A"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvFullname" runat="server"
                                        ControlToValidate="txtFullname" ValidationGroup="vgRegister"
                                        ErrorMessage="Họ và tên không được để trống!" Text="Vui lòng nhập họ và tên."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Số điện thoại <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-telephone text-secondary"></i></span>
                                        <asp:TextBox ID="txtPhone" runat="server" MaxLength="15" CssClass="form-control" Style="max-width: 100%;" placeholder="09xxxxxxxx"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                        ControlToValidate="txtPhone" ValidationGroup="vgRegister"
                                        ErrorMessage="Số điện thoại không được để trống!" Text="Vui lòng nhập số điện thoại."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revPhone" runat="server"
                                        ControlToValidate="txtPhone" ValidationGroup="vgRegister"
                                        ValidationExpression="^(0[3|5|7|8|9])+([0-9]{8})$"
                                        ErrorMessage="Số điện thoại không hợp lệ (gồm 10 chữ số, bắt đầu bằng 03, 05, 07, 08, 09)!" Text="Số điện thoại phải gồm 10 số hợp lệ."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Email</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-envelope text-secondary"></i></span>
                                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="100" CssClass="form-control" Style="max-width: 100%;" placeholder="example@gmail.com"></asp:TextBox>
                                    </div>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                        ControlToValidate="txtEmail" ValidationGroup="vgRegister"
                                        ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                                        ErrorMessage="Địa chỉ Email không đúng định dạng!" Text="Email không đúng định dạng."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold small">Địa chỉ nhận hàng</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-geo-alt text-secondary"></i></span>
                                        <asp:TextBox ID="txtAddress" runat="server" MaxLength="255" CssClass="form-control" Style="max-width: 100%;" placeholder="Số nhà, tên đường, Phường/Xã, Quận/Huyện, Tỉnh/TP..."></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Mật khẩu <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-lock text-secondary"></i></span>
                                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" Style="max-width: 100%;" TextMode="Password" placeholder="Tối thiểu 6 ký tự"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                        ControlToValidate="txtPassword" ValidationGroup="vgRegister"
                                        ErrorMessage="Mật khẩu không được để trống!" Text="Vui lòng nhập mật khẩu."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revPassword" runat="server"
                                        ControlToValidate="txtPassword" ValidationGroup="vgRegister"
                                        ValidationExpression="^.{6,255}$"
                                        ErrorMessage="Mật khẩu phải có ít nhất 6 ký tự!" Text="Mật khẩu phải từ 6 ký tự trở lên."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Nhập lại mật khẩu <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-check2-circle text-secondary"></i></span>
                                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" Style="max-width: 100%;" TextMode="Password" placeholder="Xác nhận lại mật khẩu"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                                        ControlToValidate="txtConfirmPassword" ValidationGroup="vgRegister"
                                        ErrorMessage="Vui lòng nhập lại mật khẩu xác nhận!" Text="Vui lòng xác nhận mật khẩu."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                    <asp:CompareValidator ID="cvConfirmPassword" runat="server"
                                        ControlToValidate="txtConfirmPassword"
                                        ControlToCompare="txtPassword"
                                        Operator="Equal" Type="String"
                                        ValidationGroup="vgRegister"
                                        ErrorMessage="Mật khẩu xác nhận không khớp với mật khẩu đã nhập!" Text="Mật khẩu xác nhận không khớp."
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>
                            </div>

                            <asp:Button ID="btnDangKy" runat="server" Text="HOÀN TẤT ĐĂNG KÝ"
                                ValidationGroup="vgRegister"
                                CssClass="btn btn-danger w-100 py-2 fw-bold rounded-3 shadow-sm mt-4 mb-3"
                                Style="max-width: 100%;"
                                OnClick="btnDangKy_Click" />

                            <div class="text-center pt-3 border-top">
                                <span class="text-secondary small">Bạn đã có tài khoản? </span>
                                <a href="TrangDangNhap" class="text-danger fw-bold text-decoration-none small">Đăng nhập ngay</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
