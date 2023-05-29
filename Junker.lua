local function JunkerRepairAllItems()

    if not (CanMerchantRepair()) then
        return false;
    end

    if (IsInGuild(UnitName("player")) and CanGuildBankRepair()) then
        if not (RepairAllItems(1)) then
            RepairAllItems();
        end
    else
        RepairAllItems();
    end
end

local function JunkerSellGrayItems()
    local i = 0;
    repeat
        local slots = C_Container.GetContainerNumSlots(i)
        if not (slots == nil) then
            local j = 1;
            repeat
                local link = C_Container.GetContainerItemLink(i, j);
                if not (link == nil) then
                    local _, _, quality = GetItemInfo(link);
                    if (quality == 0) then
                        C_Container.UseContainerItem(i, j);
                    end
                end
                j = j + 1;
            until (j >= slots + 1)
        end
        i = i + 1;
    until (i >= 5)
end

function JunkerInit()
    frmjunker:RegisterEvent("MERCHANT_SHOW");
end

function JunkerEvent()
    JunkerRepairAllItems();
    JunkerSellGrayItems();
end