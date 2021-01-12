need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::BackingDeviceChoice;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::TrunkAdapters;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::IPInterface;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                                                    $names-checked          = False;
my      Bool                                                                                                                                                                    $analyzed               = False;
my      Lock                                                                                                                                                                    $lock                   = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                                                               $.config                is required;
has     Bool                                                                                                                                                                    $.initialized           = False;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::BackingDeviceChoice $.BackingDeviceChoice   is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.HighAvailabilityMode  is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.DeviceName            is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.JumboFramesEnabled    is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.PortVLANID            is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.QualityOfServiceMode  is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.QueueSize             is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.ThreadModeEnabled     is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::TrunkAdapters       $.TrunkAdapters         is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::IPInterface         $.IPInterface           is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.UniqueDeviceID        is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.LargeSend             is conditional-initialization-attribute;
has     Str                                                                                                                                                                     $.ConfigurationState    is conditional-initialization-attribute;

method  xml-name-exceptions () { return set <Metadata>; }

submethod TWEAK {
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_SUBMETHOD>;
    my $proceed-with-name-check = False;
    my $proceed-with-analyze    = False;
    $lock.protect({
        if !$analyzed           { $proceed-with-analyze    = True; $analyzed      = True; }
        if !$names-checked      { $proceed-with-name-check = True; $names-checked = True; }
    });
    self.etl-node-name-check    if $proceed-with-name-check;
    self.init;
    self.analyze                if $proceed-with-analyze;
    self;
}

method init () {
    return self                 if $!initialized;
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    if self.attribute-is-accessed(self.^name, 'BackingDeviceChoice') {
        $!BackingDeviceChoice   = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::BackingDeviceChoice.new(:$!config, :xml(self.etl-branch(:TAG<BackingDeviceChoice>, :$!xml)));
    }
    $!HighAvailabilityMode      = self.etl-text(:TAG<HighAvailabilityMode>, :$!xml) if self.attribute-is-accessed(self.^name, 'HighAvailabilityMode');
    $!DeviceName                = self.etl-text(:TAG<DeviceName>,           :$!xml) if self.attribute-is-accessed(self.^name, 'DeviceName');
    $!JumboFramesEnabled        = self.etl-text(:TAG<JumboFramesEnabled>,   :$!xml) if self.attribute-is-accessed(self.^name, 'JumboFramesEnabled');
    $!PortVLANID                = self.etl-text(:TAG<PortVLANID>,           :$!xml) if self.attribute-is-accessed(self.^name, 'PortVLANID');
    $!QualityOfServiceMode      = self.etl-text(:TAG<QualityOfServiceMode>, :$!xml) if self.attribute-is-accessed(self.^name, 'QualityOfServiceMode');
    $!QueueSize                 = self.etl-text(:TAG<QueueSize>,            :$!xml) if self.attribute-is-accessed(self.^name, 'QueueSize');
    $!ThreadModeEnabled         = self.etl-text(:TAG<ThreadModeEnabled>,    :$!xml) if self.attribute-is-accessed(self.^name, 'ThreadModeEnabled');
    if self.attribute-is-accessed(self.^name, 'TrunkAdapters') {
        $!TrunkAdapters         = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::TrunkAdapters.new(:$!config, :xml(self.etl-branch(:TAG<TrunkAdapters>, :$!xml)));
    }
    if self.attribute-is-accessed(self.^name, 'IPInterface') {
        $!IPInterface           = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::IPInterface.new(:$!config, :xml(self.etl-branch(:TAG<IPInterface>, :$!xml)));
    }
    $!UniqueDeviceID            = self.etl-text(:TAG<UniqueDeviceID>,       :$!xml) if self.attribute-is-accessed(self.^name, 'UniqueDeviceID');
    $!LargeSend                 = self.etl-text(:TAG<LargeSend>,            :$!xml) if self.attribute-is-accessed(self.^name, 'LargeSend');
    $!ConfigurationState        = self.etl-text(:TAG<ConfigurationState>,   :$!xml) if self.attribute-is-accessed(self.^name, 'ConfigurationState');
    $!xml                       = Nil;
    $!initialized               = True;
    self;
}

=finish
