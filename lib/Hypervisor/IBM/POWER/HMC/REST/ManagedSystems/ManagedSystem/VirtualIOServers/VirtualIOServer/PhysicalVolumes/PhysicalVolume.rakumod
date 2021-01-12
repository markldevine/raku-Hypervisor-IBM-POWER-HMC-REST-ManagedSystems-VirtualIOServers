need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PhysicalVolumes::PhysicalVolume:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked              = False;
my      Bool                                        $analyzed                   = False;
my      Lock                                        $lock                       = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config                    is required;
has     Bool                                        $.initialized               = False;
has     Str                                         $.Description               is conditional-initialization-attribute;
has     Str                                         $.LocationCode              is conditional-initialization-attribute;
has     Str                                         $.ReservePolicy             is conditional-initialization-attribute;
has     Str                                         $.ReservePolicyAlgorithm    is conditional-initialization-attribute;
has     Str                                         $.UniqueDeviceID            is conditional-initialization-attribute;
has     Str                                         $.AvailableForUsage         is conditional-initialization-attribute;
has     Str                                         $.VolumeCapacity            is conditional-initialization-attribute;
has     Str                                         $.VolumeName                is conditional-initialization-attribute;
has     Str                                         $.VolumeState               is conditional-initialization-attribute;
has     Str                                         $.VolumeUniqueID            is conditional-initialization-attribute;
has     Str                                         $.IsFibreChannelBacked      is conditional-initialization-attribute;
has     Str                                         $.IsISCSIBacked             is conditional-initialization-attribute;
has     Str                                         $.StorageLabel              is conditional-initialization-attribute;
has     Str                                         $.DescriptorPage83          is conditional-initialization-attribute;

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
    $!Description               = self.etl-text(:TAG<Description>,              :$!xml) if self.attribute-is-accessed(self.^name, 'Description');
    $!LocationCode              = self.etl-text(:TAG<LocationCode>,             :$!xml) if self.attribute-is-accessed(self.^name, 'LocationCode');
    $!ReservePolicy             = self.etl-text(:TAG<ReservePolicy>,            :$!xml) if self.attribute-is-accessed(self.^name, 'ReservePolicy');
    $!ReservePolicyAlgorithm    = self.etl-text(:TAG<ReservePolicyAlgorithm>,   :$!xml) if self.attribute-is-accessed(self.^name, 'ReservePolicyAlgorithm');
    $!UniqueDeviceID            = self.etl-text(:TAG<UniqueDeviceID>,           :$!xml) if self.attribute-is-accessed(self.^name, 'UniqueDeviceID');
    $!AvailableForUsage         = self.etl-text(:TAG<AvailableForUsage>,        :$!xml) if self.attribute-is-accessed(self.^name, 'AvailableForUsage');
    $!VolumeCapacity            = self.etl-text(:TAG<VolumeCapacity>,           :$!xml) if self.attribute-is-accessed(self.^name, 'VolumeCapacity');
    $!VolumeName                = self.etl-text(:TAG<VolumeName>,               :$!xml) if self.attribute-is-accessed(self.^name, 'VolumeName');
    $!VolumeState               = self.etl-text(:TAG<VolumeState>,              :$!xml) if self.attribute-is-accessed(self.^name, 'VolumeState');
    $!VolumeUniqueID            = self.etl-text(:TAG<VolumeUniqueID>,           :$!xml) if self.attribute-is-accessed(self.^name, 'VolumeUniqueID');
    $!IsFibreChannelBacked      = self.etl-text(:TAG<IsFibreChannelBacked>,     :$!xml) if self.attribute-is-accessed(self.^name, 'IsFibreChannelBacked');
    $!IsISCSIBacked             = self.etl-text(:TAG<IsISCSIBacked>,            :$!xml) if self.attribute-is-accessed(self.^name, 'IsISCSIBacked');
    $!StorageLabel              = self.etl-text(:TAG<StorageLabel>,             :$!xml) if self.attribute-is-accessed(self.^name, 'StorageLabel');
    $!DescriptorPage83          = self.etl-text(:TAG<DescriptorPage83>,         :$!xml) if self.attribute-is-accessed(self.^name, 'DescriptorPage83');
    $!xml                       = Nil;
    $!initialized               = True;
    self;
}

=finish
