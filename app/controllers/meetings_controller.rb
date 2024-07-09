class MeetingsController < ApplicationController
  before_action :set_meeting
  
  def sync_status
    authorize_and_render do
      in_progress_sync_status = @meeting.in_progress_sync_status
      render json: { in_progress_sync_status: in_progress_sync_status }, status: :ok
    end
  end

  def last_sync_success
    authorize_and_render do
      last_sync_success = @meeting.last_sync_success
      render json: { last_sync_success: last_sync_success }, status: :ok
    end
  end

  private

  def set_meeting
    # TODO: use Redis here to cache the latest meeting data so that we can avoid this database lookup on each API call
    # bust the cache each time an async job updates one of these fields: in_progress_sync_status, last_sync_success, or last_sync_at
    @meeting = Meeting.find_by(id: params[:meeting_id])
  end

  def authorize_and_render
    if !@meeting
      render json: { error: 'Not found' }, status: :not_found
    elsif @meeting.user_id != current_user.id
      render json: { error: 'Unauthorized' }, status: :unauthorized
    else
      yield
    end
  end
end
