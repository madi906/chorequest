"use client";

import { useState } from "react";
import { supabase } from "@/lib/supabase";

type Child = {
  app_user_id: string;
  app_user_name: string;
  point_balance: number;
};

type Reward = {
  reward_id: string;
  reward_name: string;
  point_cost: number;
  available_quantity: number | null;
  is_active: boolean;
};

type RedemptionResult = {
  redemption_id: string;
  redemption_reference_no: string;
  reward_id: string;
  redeemed_by: string;
  points_used: number;
  redemption_status: string;
};

type RewardRedemptionPanelProps = {
  childUsers: Child[];
  reward: Reward;
};

export default function RewardRedemptionPanel({
  childUsers,
  reward,
}: RewardRedemptionPanelProps) {
  const [selectedChildId, setSelectedChildId] = useState(
    childUsers[0]?.app_user_id ?? ""
  );

  const [isRedeeming, setIsRedeeming] = useState(false);
  const [successMessage, setSuccessMessage] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  const selectedChild = childUsers.find(
    (child) => child.app_user_id === selectedChildId
  );

  const balance = selectedChild?.point_balance ?? 0;

  const hasEnoughPoints = balance >= reward.point_cost;

  const hasQuantity =
    reward.available_quantity === null ||
    reward.available_quantity > 0;

  const canRedeem =
    reward.is_active &&
    hasEnoughPoints &&
    hasQuantity &&
    !isRedeeming;

  let disabledReason = "";

  if (!reward.is_active) {
    disabledReason = "Reward is inactive.";
  } else if (!hasQuantity) {
    disabledReason = "Reward is currently unavailable.";
  } else if (!hasEnoughPoints) {
    disabledReason = `Needs ${
      reward.point_cost - balance
    } more points.`;
  }

  async function handleRedeem() {
    if (!selectedChild || !canRedeem) {
      return;
    }

    setIsRedeeming(true);
    setSuccessMessage("");
    setErrorMessage("");

    const { data, error } = await supabase.rpc("redeem_reward", {
      p_reward_id: reward.reward_id,
      p_redeemed_by: selectedChild.app_user_id,
      p_comment: "Reward redeemed from ChoreQuest.",
    });

    if (error) {
      setErrorMessage(error.message);
      setIsRedeeming(false);
      return;
    }

    const redemption = Array.isArray(data)
      ? (data[0] as RedemptionResult | undefined)
      : (data as RedemptionResult | null);

    if (!redemption) {
      setErrorMessage(
        "The redemption was processed, but no redemption details were returned."
      );
      setIsRedeeming(false);
      return;
    }

    setSuccessMessage(
      `Redemption ${redemption.redemption_reference_no} created successfully.`
    );

    setIsRedeeming(false);
  }

  return (
    <div className="mt-5 space-y-3 border-t pt-5">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div className="min-w-0">
          <label
            htmlFor={`child-${reward.reward_id}`}
            className="block text-sm font-medium text-gray-700"
          >
            Redeem as
          </label>

          <select
            id={`child-${reward.reward_id}`}
            value={selectedChildId}
            onChange={(event) => {
              setSelectedChildId(event.target.value);
              setSuccessMessage("");
              setErrorMessage("");
            }}
            disabled={isRedeeming}
            className="mt-1 w-full rounded-lg border bg-white px-3 py-2 text-sm sm:w-auto disabled:cursor-not-allowed disabled:bg-gray-100"
          >
            {childUsers.map((child) => (
              <option
                key={child.app_user_id}
                value={child.app_user_id}
              >
                {child.app_user_name}
              </option>
            ))}
          </select>
        </div>

        <div className="text-sm text-gray-600">
          Balance:{" "}
          <span className="font-semibold text-gray-900">
            ⭐ {balance} points
          </span>
        </div>
      </div>

      <button
        type="button"
        disabled={!canRedeem}
        onClick={handleRedeem}
        className="w-full rounded-lg bg-gray-900 px-4 py-2 text-sm font-semibold text-white transition hover:bg-gray-800 disabled:cursor-not-allowed disabled:bg-gray-300 sm:w-auto"
      >
        {isRedeeming ? "Redeeming..." : "Redeem"}
      </button>

      {disabledReason && !isRedeeming && (
        <p className="text-sm text-gray-500">
          {disabledReason}
        </p>
      )}

      {successMessage && (
        <div className="rounded-lg border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700">
          {successMessage}
        </div>
      )}

      {errorMessage && (
        <div className="rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
          Redemption failed: {errorMessage}
        </div>
      )}
    </div>
  );
}