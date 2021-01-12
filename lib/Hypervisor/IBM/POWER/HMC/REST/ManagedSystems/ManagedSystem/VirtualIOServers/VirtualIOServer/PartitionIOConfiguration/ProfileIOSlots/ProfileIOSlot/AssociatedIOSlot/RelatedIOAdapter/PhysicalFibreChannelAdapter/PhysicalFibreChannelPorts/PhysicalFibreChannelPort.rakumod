need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
need    Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts::PhysicalFibreChannelPort::PhysicalVolumes;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts::PhysicalFibreChannelPort:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                                                                                                                                                                                                                                                                                $names-checked      = False;
my      Bool                                                                                                                                                                                                                                                                                                $analyzed           = False;
my      Lock                                                                                                                                                                                                                                                                                                $lock               = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config                                                                                                                                                                                                                                                           $.config            is required;
has     Bool                                                                                                                                                                                                                                                                                                $.initialized       = False;
has     Str                                                                                                                                                                                                                                                                                                 $.LocationCode      is conditional-initialization-attribute;
has     Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts::PhysicalFibreChannelPort::PhysicalVolumes $.PhysicalVolumes   is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                                                                 $.PortName          is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                                                                 $.UniqueDeviceID    is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                                                                 $.WWPN              is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                                                                 $.WWNN              is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                                                                 $.AvailablePorts    is conditional-initialization-attribute;
has     Str                                                                                                                                                                                                                                                                                                 $.TotalPorts        is conditional-initialization-attribute;

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
    return self             if $!initialized;
    self.config.diag.post:  self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!LocationCode          = self.etl-text(:TAG<LocationCode>          :$!xml) if self.attribute-is-accessed(self.^name, 'LocationCode');
    if self.attribute-is-accessed(self.^name, 'PhysicalVolumes') {
        $!PhysicalVolumes   = Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionIOConfiguration::ProfileIOSlots::ProfileIOSlot::AssociatedIOSlot::RelatedIOAdapter::PhysicalFibreChannelAdapter::PhysicalFibreChannelPorts::PhysicalFibreChannelPort::PhysicalVolumes.new(:$!config, :xml(self.etl-branch(:TAG<PhysicalVolumes>, :$!xml)));
    }
    $!PortName              = self.etl-text(:TAG<PortName>              :$!xml) if self.attribute-is-accessed(self.^name, 'PortName');
    $!UniqueDeviceID        = self.etl-text(:TAG<UniqueDeviceID>        :$!xml) if self.attribute-is-accessed(self.^name, 'UniqueDeviceID');
    $!WWPN                  = self.etl-text(:TAG<WWPN>                  :$!xml) if self.attribute-is-accessed(self.^name, 'WWPN');
    $!WWNN                  = self.etl-text(:TAG<WWNN>                  :$!xml) if self.attribute-is-accessed(self.^name, 'WWNN');
    $!AvailablePorts        = self.etl-text(:TAG<AvailablePorts>        :$!xml) if self.attribute-is-accessed(self.^name, 'AvailablePorts');
    $!TotalPorts            = self.etl-text(:TAG<TotalPorts>            :$!xml) if self.attribute-is-accessed(self.^name, 'TotalPorts');
    $!xml                   = Nil;
    $!initialized           = True;
    self;
}

=finish
