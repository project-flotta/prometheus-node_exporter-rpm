%define _build_id_links none

Name:       node_exporter
Version:    1.3.1
Release:    1%{?dist}
Summary:    Prometheus Node Exporter
ExclusiveArch: %{go_arches}
Group:      Flotta
License:    GPL
Source0:    %{name}-%{version}.tar.gz

BuildRequires:  golang
BuildRequires:  systemd

Provides:       %{name} = %{version}-%{release}
Provides:       golang(%{go_import_path}) = %{version}-%{release}

%description
The Prometheus Node Exporter collects and exposes system metrics.

%prep 
tar fx %{SOURCE0}

%build
cd %{name}-%{VERSION}
go build

%install
cd %{name}-%{VERSION}
mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}%{_unitdir}
install node_exporter %{buildroot}/usr/bin
install node_exporter.service %{buildroot}%{_unitdir}

%files
/usr/bin/node_exporter
%{_unitdir}/node_exporter.service
