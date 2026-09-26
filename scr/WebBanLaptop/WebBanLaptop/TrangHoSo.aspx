<%@ Page Title="Hồ sơ cá nhân" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrangHoSo.aspx.cs" Inherits="WebBanLaptop.TrangHoSo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-4 my-lg-5">

        <!-- Thông báo cập nhật thành công / lỗi -->
        <asp:Panel ID="pnlThongBao" runat="server" Visible="false" CssClass="alert rounded-3 py-2 small mb-4 shadow-sm">
            <asp:Label ID="lblThongBao" runat="server"></asp:Label>
        </asp:Panel>

        <div class="row g-4">

            <!-- ================= CỘT TRÁI: SIDEBAR TÀI KHOẢN ================= -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="bg-danger bg-gradient p-4 text-center text-white">
                        <!-- Nhấn vào hình tròn để mở Modal xem ảnh to & đổi ảnh -->
                        <div class="position-relative d-inline-block mb-3" style="cursor: pointer;"
                            data-bs-toggle="modal" data-bs-target="#modalAvatar" title="Nhấn để xem và đổi ảnh đại diện">
                            <asp:Image ID="imgAvatarHienTai" runat="server"
                                ImageUrl="~/Images/default-avatar.png"
                                CssClass="rounded-circle border border-3 border-white shadow object-fit-cover bg-white"
                                Style="width: 110px; height: 110px;" />
                            <span class="position-absolute bottom-0 end-0 bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center border border-2 border-white shadow-sm"
                                style="width: 32px; height: 32px;">
                                <i class="bi bi-camera-fill small"></i>
                            </span>
                        </div>

                        <h5 class="fw-bold mb-1">
                            <asp:Label ID="lblSidebarFullname" runat="server" Text="Tên người dùng"></asp:Label>
                        </h5>
                        <p class="text-white-50 small mb-2">
                            @<asp:Label ID="lblSidebarUsername" runat="server" Text="username"></asp:Label>
                        </p>
                        <asp:Label ID="lblVaiTro" runat="server" CssClass="badge bg-warning text-dark rounded-pill px-3 py-1 fw-bold" Text="Thành viên"></asp:Label>
                    </div>

                    <!-- Menu điều hướng nhanh -->
                    <div class="card-body p-3">
                        <div class="list-group list-group-flush small">
                            <a href="TrangHoSo.aspx" class="list-group-item list-group-item-action active bg-danger border-danger rounded-3 mb-1 py-2">
                                <i class="bi bi-person-vcard me-2"></i>Thông tin tài khoản
                            </a>
                            <a href="DonHangCuaToi.aspx" class="list-group-item list-group-item-action rounded-3 mb-1 py-2">
                                <i class="bi bi-receipt-cutoff me-2 text-danger"></i>Đơn hàng của tôi
                            </a>
                            <asp:HyperLink ID="lnkQuanTriAdmin" runat="server" NavigateUrl="~/Admin/Default.aspx" Visible="false"
                                CssClass="list-group-item list-group-item-action rounded-3 py-2 fw-bold text-primary">
                                <i class="bi bi-speedometer2 me-2"></i> Truy cập trang Quản trị
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= CỘT PHẢI: THÔNG TIN HỒ SƠ & ĐỔI MẬT KHẨU ================= -->
            <div class="col-lg-8">

                <!-- KHỐI 1: CẬP NHẬT THÔNG TIN CÁ NHÂN -->
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-header bg-white border-bottom p-4">
                        <h5 class="fw-bold text-danger mb-1">
                            <i class="bi bi-person-lines-fill me-2"></i>HỒ SƠ CỦA TÔI
                        </h5>
                        <p class="text-secondary small mb-0">Quản lý thông tin hồ sơ để bảo mật tài khoản và giao hàng chính xác</p>
                    </div>

                    <div class="card-body p-4">
                        <div class="row g-3">
                            <!-- Tên đăng nhập (Chỉ đọc) -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person-lock text-secondary"></i></span>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control bg-light text-secondary" Style="max-width: 100%;" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Họ và tên -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Họ và tên <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person text-secondary"></i></span>
                                    <asp:TextBox ID="txtFullname" runat="server" MaxLength="100" CssClass="form-control" Style="max-width: 100%;" placeholder="Nhập họ và tên..."></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvFullname" runat="server"
                                    ControlToValidate="txtFullname" ValidationGroup="vgHoSo"
                                    ErrorMessage="Họ và tên không được để trống!"
                                    CssClass="text-danger small mt-1" Display="Dynamic" />
                            </div>

                            <!-- Số điện thoại -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Số điện thoại <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-telephone text-secondary"></i></span>
                                    <asp:TextBox ID="txtPhone" runat="server" MaxLength="15" CssClass="form-control" Style="max-width: 100%;" placeholder="09xxxxxxxx"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                    ControlToValidate="txtPhone" ValidationGroup="vgHoSo"
                                    ErrorMessage="Vui lòng nhập số điện thoại!"
                                    CssClass="text-danger small mt-1" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revPhone" runat="server"
                                    ControlToValidate="txtPhone" ValidationGroup="vgHoSo"
                                    ValidationExpression="^(0[3|5|7|8|9])+([0-9]{8})$"
                                    ErrorMessage="Số điện thoại gồm 10 số hợp lệ!"
                                    CssClass="text-danger small mt-1" Display="Dynamic" />
                            </div>

                            <!-- Email -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Địa chỉ Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-envelope text-secondary"></i></span>
                                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="100" CssClass="form-control" Style="max-width: 100%;" placeholder="example@gmail.com"></asp:TextBox>
                                </div>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                    ControlToValidate="txtEmail" ValidationGroup="vgHoSo"
                                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                                    ErrorMessage="Email không đúng định dạng!"
                                    CssClass="text-danger small mt-1" Display="Dynamic" />
                            </div>

                            <!-- Địa chỉ nhận hàng -->
                            <div class="col-12">
                                <label class="form-label fw-semibold small">Địa chỉ nhận hàng mặc định</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-geo-alt text-secondary"></i></span>
                                    <asp:TextBox ID="txtAddress" runat="server" MaxLength="255" CssClass="form-control" Style="max-width: 100%;" placeholder="Số nhà, tên đường, Phường/Xã, Quận/Huyện, Tỉnh/TP..."></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 text-end">
                            <asp:Button ID="btnCapNhatHoSo" runat="server" Text="LƯU THAY ĐỔI"
                                ValidationGroup="vgHoSo"
                                CssClass="btn btn-danger px-4 py-2 fw-bold rounded-3 shadow-sm"
                                OnClick="btnCapNhatHoSo_Click" />
                        </div>
                    </div>
                </div>

                <!-- KHỐI 2: ĐỔI MẬT KHẨU (Ẩn mặc định, nhấn vào mới hiện ra) -->
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 p-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-bold text-danger mb-1">
                                <i class="bi bi-shield-lock-fill me-2"></i>BẢO MẬT & MẬT KHẨU
                            </h5>
                            <p class="text-secondary small mb-0">Thay đổi mật khẩu định kỳ để bảo vệ tài khoản</p>
                        </div>
                        <button class="btn btn-outline-danger btn-sm px-3 py-2 fw-semibold rounded-3" type="button"
                            data-bs-toggle="collapse" data-bs-target="#collapseDoiMatKhau" aria-expanded="false">
                            <i class="bi bi-key me-1"></i>Đổi mật khẩu
                        </button>
                    </div>

                    <!-- Khung Collapse chứa form đổi mật khẩu -->
                    <div class="collapse <%= GiuMoKhungMatKhau %>" id="collapseDoiMatKhau">
                        <div class="card-body p-4 pt-0 border-top">
                            <div class="row g-3 mt-1">
                                <!-- Mật khẩu hiện tại -->
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold small">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtMatKhauCu" runat="server" TextMode="Password" CssClass="form-control" Style="max-width: 100%;" placeholder="Nhập mật khẩu cũ"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMatKhauCu" runat="server"
                                        ControlToValidate="txtMatKhauCu" ValidationGroup="vgMatKhau"
                                        ErrorMessage="Nhập mật khẩu hiện tại!"
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <!-- Mật khẩu mới -->
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold small">Mật khẩu mới <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtMatKhauMoi" runat="server" TextMode="Password" CssClass="form-control" Style="max-width: 100%;" placeholder="Tối thiểu 6 ký tự"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMatKhauMoi" runat="server"
                                        ControlToValidate="txtMatKhauMoi" ValidationGroup="vgMatKhau"
                                        ErrorMessage="Nhập mật khẩu mới!"
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revMatKhauMoi" runat="server"
                                        ControlToValidate="txtMatKhauMoi" ValidationGroup="vgMatKhau"
                                        ValidationExpression="^.{6,255}$"
                                        ErrorMessage="Tối thiểu 6 ký tự!"
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>

                                <!-- Xác nhận mật khẩu mới -->
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold small">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtXacNhanMatKhau" runat="server" TextMode="Password" CssClass="form-control" Style="max-width: 100%;" placeholder="Nhập lại mật khẩu mới"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvXacNhanMK" runat="server"
                                        ControlToValidate="txtXacNhanMatKhau" ValidationGroup="vgMatKhau"
                                        ErrorMessage="Xác nhận lại mật khẩu!"
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                    <asp:CompareValidator ID="cvXacNhanMK" runat="server"
                                        ControlToValidate="txtXacNhanMatKhau" ControlToCompare="txtMatKhauMoi"
                                        ValidationGroup="vgMatKhau" Operator="Equal" Type="String"
                                        ErrorMessage="Mật khẩu mới không khớp!"
                                        CssClass="text-danger small mt-1" Display="Dynamic" />
                                </div>
                            </div>

                            <div class="mt-4 text-end">
                                <asp:Button ID="btnDoiMatKhau" runat="server" Text="CẬP NHẬT MẬT KHẨU"
                                    ValidationGroup="vgMatKhau"
                                    CssClass="btn btn-danger px-4 py-2 fw-bold rounded-3 shadow-sm"
                                    OnClick="btnDoiMatKhau_Click" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- ================= MODAL PHÓNG TO & ĐỔI ẢNH ĐẠI DIỆN ================= -->
    <div class="modal fade" id="modalAvatar" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow rounded-4">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title fw-bold text-danger">
                        <i class="bi bi-person-bounding-box me-2"></i>Ảnh đại diện của bạn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center p-4">
                    <!-- Ảnh đại diện phóng to (240x240px) -->
                    <asp:Image ID="imgAvatarModal" runat="server"
                        ImageUrl="~/Images/default-avatar.png"
                        CssClass="rounded-circle border border-4 border-danger border-opacity-25 shadow object-fit-cover bg-light mb-4"
                        Style="width: 240px; height: 240px;" />

                    <div class="text-start bg-light p-3 rounded-3">
                        <label class="form-label fw-semibold small text-secondary mb-2">Chọn ảnh mới từ máy tính:</label>
                        <asp:FileUpload ID="fuAvatar" runat="server" CssClass="form-control" Style="max-width: 100%;"
                            accept=".jpg,.jpeg,.png,.webp" onchange="xemTruocAvatar(this);" />
                        <small class="text-muted d-block mt-1">Định dạng hỗ trợ: .JPG, .PNG, .WEBP</small>
                    </div>
                </div>
                <div class="modal-footer border-top-0 pt-0 px-4 pb-4">
                    <button type="button" class="btn btn-light rounded-3 px-3" data-bs-dismiss="modal">Đóng</button>
                    <asp:Button ID="btnLuuAvatar" runat="server" Text="LƯU ẢNH ĐẠI DIỆN"
                        CausesValidation="false"
                        CssClass="btn btn-danger fw-bold rounded-3 px-4"
                        OnClick="btnLuuAvatar_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Script xem trước ảnh ngay khi chọn file trong Modal -->
    <script>
        function xemTruocAvatar(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgAvatarModal.ClientID %>').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
